package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class MenufoodManager {
	 // Method สำหรับดึงข้อมูลผู้ใช้ทั้งหมดจากตาราง Register
		public List<MenuFood> getAllMenufood() {
			List<MenuFood> menulist = new ArrayList<>();
			Session session = null;
			try {
				SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
				session = sessionFactory.openSession();

				menulist = session.createQuery("FROM MenuFood", MenuFood.class).list(); 
				System.out.println("Number of users retrieved: " + menulist.size());

			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (session != null) {
					session.close(); // Ensure the session is closed even on exception
				}
			}
			return menulist;
		}
		
		public List<Tables> getAllListTable() {
			List<Tables> tablelist = new ArrayList<>();
			Session session = null;
			try {
				SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
				session = sessionFactory.openSession();

				tablelist = session.createQuery("FROM Tables", Tables.class).list(); 
				System.out.println("Number of users retrieved: " + tablelist.size());

			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (session != null) {
					session.close(); // Ensure the session is closed even on exception
				}
			}
			return tablelist;
		}
}
