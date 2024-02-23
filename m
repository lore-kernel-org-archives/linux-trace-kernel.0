Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BE7B3D9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688815; cv=none; b=nhz5pA4ynsX2Hi4G7nA4UfAEMxi5cR+YfcuiMvCm3zkonOTvd789JOG0YdbP+6Qer4jHdFNNDGMVQShYpS9qhenB1ZFIms7mVJxIB1QAQ5QLF1FZCW5dzqIRJj0ISloMq1XXzKVfehXa3uFf/PJrpPOXpChL+a64hJzJKvoKSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688815; c=relaxed/simple;
	bh=AL59q193AhGQ1MjN1i4e9LV1QO1+0Mpm+Q7EAlw3k8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+HNn85Sl/JOSjVfGYLNqw9w5jNLcvS5cvVxm5p4dg+K2CEphasnhGBjw5othTN02MhwqYEfg5yhgcUC5Ww5MRxPr4eBfAMYi+KQyU7T4dzujXlWPpXH63JhetvPflqmGxQvk04Pmvxe5cYKVmxRcI9331vsVPhsBAPluzqGi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=OlH4nMjh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OlH4nMjh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso985594e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688811; x=1709293611; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=OlH4nMjh0EloGzrJWFBsJpUG2iSmTL9g/7ig3moN4NpE/n/o9hdn+OGilrtJrGPAFW
         onB4t89dAUbt/GRgf0gjMVFm2H2WUFuQTXcyLL5bLj/GiWk+39Zm0Pi4OVGA4uIWA46M
         Sj3A9HxxvsbDSvcKy/yx4SHddG19JOtwefA+vHuzX+bTH2/VNVGmlv8uCNgVMUp/p1Kw
         7KJuqEOAkfQEgIIzrQDiKjBf6E+hyReXCjChB3oaDsCVzHEMVj4ERnnoLL9utq29NXqd
         jlTGSslHYJWyhhKUG7JnDBsTtTUum4mZncvvqqfl/VFWlsEkaZSyp8ZR3f8VBg42qKfM
         5ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688811; x=1709293611;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=Ufb9PkqPavqqdRCTAsfk7+LmUOE4cS5aYvusHXGbSTyGQkWC2A/qzq0SyrXRtWsBM9
         Gif3LdaZG+9a/yu7vjkEYdQVj8wFAwyxk17igxLBNq7Pk4rsgWWsQAxBn35jWRNftSKR
         Lo4Q2a6ByHKPdN1ZY2yycYKWC9cRaw2xUO3rIASYG3tpI0XS/OSrlplfJlGGhxL0six/
         E51GWEuplCUAwA6UQkgKWdiY9MN3/8fhhp1QQ5aukCakR6UGXNdf5HJjB3mCGk47Q8V1
         +1A4lwh4MfKoO43I7gANyD8Qhdgme62u2PzAtf3ab3bgLZVjX2TE2NFw85QAIIdmoGb6
         pR0w==
X-Forwarded-Encrypted: i=1; AJvYcCVXwFGHuFGdw3CkK+t3kzfkJrMh76Rmuq0MOSf0Q9UgJjK9kqTpQsYcPiXdVAOkg9ib9Qhy7eDiYOjsAVFBl6Qy3bAcoJhmQ4+RwQRy+17Gq9ZB
X-Gm-Message-State: AOJu0YxnyrkEFTicwssZHjmqmSrWmbSvWYvyr3JImsQ4mY0RkmxCUumm
	JMhdtInlqvfAtdsm5RVpeSsLV6zBKVL59M4xLqxdpsFe7glQQ133N3yU6MaqhVg=
X-Google-Smtp-Source: AGHT+IE1FodzdIAUfG29+EdpmzWKwJ/TMGMZMZ1OL3CbEJZ1hWlBLWck+b5rA0SpDIRUtCsXMcBquw==
X-Received: by 2002:a05:6512:12cb:b0:512:be57:6dcf with SMTP id p11-20020a05651212cb00b00512be576dcfmr1554566lfg.8.1708688811358;
        Fri, 23 Feb 2024 03:46:51 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 3/4] net: switchdev: Relay all replay messages through a central function
Date: Fri, 23 Feb 2024 12:44:52 +0100
Message-Id: <20240223114453.335809-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223114453.335809-1-tobias@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
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
 net/switchdev/switchdev.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 9bf387664e71..df4db720183f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -340,6 +340,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..cc9ed7f6bf1c 100644
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
index c9189a970eec..f73249269a87 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -380,6 +380,24 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
+/**
+ *	switchdev_call_replay - Replay switchdev message to driver
+ *
+ *	@nb: notifier block to send the message to
+ *	@type: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Called by a bridge, in a response to a replay request
+ *	initiated by a port that is either attaching to, or detaching
+ *	from, that bridge.
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

