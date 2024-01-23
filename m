Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83060EE0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024255; cv=none; b=NX8M8RhA05wf5RmA8i5kIfrs6qbu/2kNbREIAc/xOW9Y061+Qm7m5WbXX/lduCcD1976wznqO8L8172iQ2NLSVVHxAKTvFDVuwrikTOygi4HIQhw4caCM45mtg/b0UbvPHIUMomF/MeZjedyqaIsOcNagfCW++lVSsu4a5G7BI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024255; c=relaxed/simple;
	bh=1TsJyYbT/1jV7UKlwxvsd6loFO5APSuHrGhqo+8jwhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpir/7/JTYxCeA4SPMukAamRPcPg3DFpxJJS7HHme/yKyNOtuUnaTd9rHEDa2DK3XLPGpO3y1gU+dknnq2L57naC0myeUHbNcQZbPMS7PQgLNkwI/ChgLh0q8jHljuCWtWlRUxIigyvVN2vv65yT2Y+cx3uDab69kg0qY+fZZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=pyDZMpMV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="pyDZMpMV"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51005675963so1449718e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024251; x=1706629051; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ummukqbZPLomPcHTqdN4PTAj0S043AFrvZ+O3aml3do=;
        b=pyDZMpMV3sQZNjsTnxv7kH4FRwFtMYchkuRaHwaI9czp69Z1efPimswwdiLiZBsbDQ
         9I2Qk5spCHZKgPoQWm+YRam28vV38MTkbqX3LhHAm6j+MKA1/W91/yC1OdyLE8eRYO5Y
         1vJsKAVLofb4MrkNocGnAtwRTMY404sbTyGAmmpF8bfjFslveiv16cg3SLrH9uqNs5Cy
         JRkoF6UyZ4jdKsEIQ9kkuYOqs+ZWOo1vHM+DVXF6m1afAuSGu0NMYsC4uYwd0UazisQt
         aTTcAVW+pCw8dyMzjFv/aEUcZoMTh4mD5jR8DO893cR4FtM3pW1VFJmZ+8eukkSYLJ+a
         OlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024251; x=1706629051;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ummukqbZPLomPcHTqdN4PTAj0S043AFrvZ+O3aml3do=;
        b=Jk++YZapeRLn1JU6HI2+EKJiLcOdHkmUD+/ZeIc4aZK3rbkI9pgLbsA5EaPxTxQ+Nd
         AyuwJ1bPmlkbURpqVMnKVGsT/YNmFbkKgxkK5MFbdPEbBxZGFokcQHSzYIKeZ5PAadbs
         J79xPqjy7ZpFJD6OwoTXN0/hT4r2DU3WFfb1SewGsObSCCOIztKPhZVMv2QitznZMHqu
         9yD/CYVcdfY4dqXdjzCIC0tmEqxw6rhKdi3ZAnoh+XkA0H4RMVOqT/3bSc2ZJ25+4xLU
         qSzlCx4zh2lQFi84Ri5SUWhC4V50xMaWQ6jnAHaekbyc80hliFv7+bvFRy2xkSF5656E
         U6Ow==
X-Gm-Message-State: AOJu0Yyg+xADFa1q3HH5LZgfy5j93hb7CMbY5bj7G3ptVIUN5n/5+ZbE
	tdeZvBHYI0hSdTt1G/w8yDghXT5nigKzGscTrBSr09m+QPl6qk5cJIU/wH4jjsc=
X-Google-Smtp-Source: AGHT+IF4GqCEHYFPDhgvrqbieCdj3I6rehdUcJG37iFiPhk/Neolyfflf2C05+vFqiv1ru5o6lhYKA==
X-Received: by 2002:ac2:5e32:0:b0:50e:c7b2:cc77 with SMTP id o18-20020ac25e32000000b0050ec7b2cc77mr1395317lfg.198.1706024250919;
        Tue, 23 Jan 2024 07:37:30 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:29 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: switchdev: Relay all replay messages through a central function
Date: Tue, 23 Jan 2024 16:37:05 +0100
Message-Id: <20240123153707.550795-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153707.550795-1-tobias@waldekranz.com>
References: <20240123153707.550795-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This will make it easier to add a tracepoint for all replay messages
later on.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br_switchdev.c | 10 +++++-----
 net/switchdev/switchdev.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 250053748c08..974cd8467131 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -337,6 +337,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..b9e69b522544 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -306,7 +306,7 @@ br_switchdev_fdb_replay_one(struct net_bridge *br, struct notifier_block *nb,
 
 	br_switchdev_fdb_populate(br, &item, fdb, ctx);
 
-	err = nb->notifier_call(nb, action, &item);
+	err = switchdev_call_replay(nb, action, &item.info);
 	return notifier_to_errno(err);
 }
 
@@ -376,8 +376,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
 			attr.u.vlan_msti.vid = v->vid;
 			attr.u.vlan_msti.msti = v->msti;
 
-			err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET,
-						&attr_info);
+			err = switchdev_call_replay(nb, SWITCHDEV_PORT_ATTR_SET,
+						    &attr_info.info);
 			err = notifier_to_errno(err);
 			if (err)
 				return err;
@@ -404,7 +404,7 @@ br_switchdev_vlan_replay_one(struct notifier_block *nb,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
@@ -590,7 +590,7 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 5b045284849e..05f22f971312 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -307,6 +307,23 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_replay - Replay switchdev message to driver
+ *	@nb: notifier block to send the message to
+ *	@val: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Typically issued by the bridge, as a response to a replay
+ *	request initiated by a port that is either attaching to, or
+ *	detaching from, that bridge.
+ */
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info)
+{
+	return nb->notifier_call(nb, type, info);
+}
+EXPORT_SYMBOL_GPL(switchdev_call_replay);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1

