Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914635CB66
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640044; cv=none; b=asTBaQlADC6ODTwTr73ZlumfdqgiTGBVccz8Kz3/YtzYbjFv2mfKPdVLSu5xGdpMCqN8SgGHwBZgEIoDUiLTWI1LE1KcuSUjH+BbO0RDp82pJsi7IScoWd+ZrAWsBFO3myXEf6QilGTU2ugRLIHK1HF9CAC3E2OLjC4yLLo3XHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640044; c=relaxed/simple;
	bh=7DRFVjIY+Ygj/L7QkL1uTDqAGAZViCzf/BNmCHn88Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMy7BZfXV6gNWBQzbzTa6b2UBz3Jftirh8yreOG16fmk326KKQ8donSmJ8QeuMKRtIxMen5fY+psKrRrFGwR1kkxpd3RMSmn27xx+pTFb7DeybDxirzrG9kNxrZgTx+7dcV5LlHCjDIf3cJYV88XHJDYNigxyt7llVmk3JLERTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KJPdwU7g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KJPdwU7g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439baf33150so2583479f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640042; x=1773244842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=KJPdwU7gVjpcfDhV1aQxSuc5yozVPQMU/1qFi/q7+Hx2sdeqbUkK4o6QOJ1b+5ElDs
         d10NH31xZl/ZiSZtwK2fusIflEr+9LwuqSCqP1orIseKmdqnGLZf7EnCZY43golne9Ly
         O+xRX1OV2lKVhKZZqMrFKzCVDbCT6s0AdY8u6/aXm0YralJ+VMipL9H9RzYfpKP5RANd
         XaOuxJEOeHTtCTBJ9h5B57DyyxYqv9Z+huyfG0dlKDwo6SNjQTZ+BTBZiALexFSgzKu0
         q5LywESpYymuHSxV3hR/vGVUa7dwIilXvFIOLEgmWKwv5lgptnsvacVtUOnS+pIPvpKt
         vG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640042; x=1773244842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=IsIVj6W610dNtI4BZtgy/RXE4d6d881QBzvxlkq6cNHj9aRkOXQGtRt7oHW75MXDpe
         c6rAvXGRkTwwZTRC5FQYBVEyhk4pShZhKJYj70thi+A9RH21EUdVvx7yE1sIG/pFENMp
         KY/J/Nv3rZRBBo3Hiz/3YwaxjL8NReYM9IPXbbsX2JuqBYcWyomCESN/WCON8eUud0qe
         rhTIqAU2HOMKdoCt3Sik2YyNh4GkDNkDGoKtAFYCUK0l1DKoFLcgfa7fTYJC92F5p+6P
         GnL0Kc70pldc3hoBiuY0oxawDpsyW9dqCz9LAFyn1Z8MmcfHZR6bvIL9ZH00xQUrdf9q
         9u3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9AgIu9bAybXoQnmK9PBMFIXEpH/KCCvrCbv2CFI9wnauF42sRvG8qqKE9aTzgHshkVM8+UdLTzN8MnAWfAljp4FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7etGV2+zPQKRF2wxjZrB9ycMKhvv3PoHImm8s/TT6k/+53flC
	nzDjiapfBkAUFqsuJpYs4rfbBJcUvhE1lwW7QlDUKkol+U012Z6/Zgovf0Vn2JkqfDU=
X-Gm-Gg: ATEYQzyWhq6SJo7xk7CRYbzVwcyYvgXfvWFM1OuSbl6BCYL7cEgPcxt0H0yrQ6ZoIoj
	4Iq3q/gFreqjfF2udtSiM6NNUl6XuMeu0aJFboegvln/Bw7a68XlRkq4ZwfbB1OXtbjbXnQnFuA
	xHIR6NqjrfgQejHe8kbEpPC4D0LX2R6WkLXESXkP7wPoZVz1+vTBK7n/sBNrrY1WFEM/8ySF0OG
	Ih0cn/8nFpNm4TJqhvPWYRlDmXKmiz4id4sKcflSNmk5+fYiJ5sK4rImKhHW8WH36mo3P0pBmA0
	7KKkAawVfFMO249A/YVYgXHbPnmBUJchtccLC77k3HD4p/Zh2/LhIAzNwujt2Rjmye8HOJmsrsA
	yu53IRdECZeDqKCvC5/L3FNtKSjv0RSW0bj8ObzkiPZLizQcbf5DW2zV3fe1faVj6tGj14w3N4B
	ycE8qZQ2gCyIkXqdgRzynk6k26dlqT6GWIAGhNOq1nqGoKtw==
X-Received: by 2002:a05:6000:2089:b0:436:3761:583b with SMTP id ffacd0b85a97d-439c113528emr11715074f8f.27.1772640041008;
        Wed, 04 Mar 2026 08:00:41 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abded86esm33624183f8f.6.2026.03.04.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:40 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 07/13] devlink: introduce __devlink_alloc() with dev driver pointer
Date: Wed,  4 Mar 2026 17:00:16 +0100
Message-ID: <20260304160022.6114-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce __devlink_alloc() as an internal devlink allocator that
accepts a struct device_driver pointer and stores it in the devlink
instance. This allows internal devlink code (e.g. shared instances)
to associate a driver with a devlink instance without need to pass dev
pointer.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/core.c          | 40 ++++++++++++++++++++++---------------
 net/devlink/devl_internal.h |  5 +++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 237558abcd63..fcb73d3e56aa 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -418,27 +418,15 @@ void devlink_unregister(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
-/**
- *	devlink_alloc_ns - Allocate new devlink instance resources
- *	in specific namespace
- *
- *	@ops: ops
- *	@priv_size: size of user private data
- *	@net: net namespace
- *	@dev: parent device
- *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
- */
-struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
-				 size_t priv_size, struct net *net,
-				 struct device *dev)
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver)
 {
 	struct devlink *devlink;
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops || !dev || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -453,6 +441,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	devlink->dev = get_device(dev);
 	devlink->ops = ops;
+	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
@@ -480,6 +469,25 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	kvfree(devlink);
 	return NULL;
 }
+
+/**
+ *	devlink_alloc_ns - Allocate new devlink instance resources
+ *	in specific namespace
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *	@net: net namespace
+ *	@dev: parent device
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
+				 size_t priv_size, struct net *net,
+				 struct device *dev)
+{
+	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
+}
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
 /**
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f0ebfb936770..3cc7e696e0fd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
 	 * port, sb, dpipe, resource, params, region, traps and more.
@@ -66,6 +67,10 @@ struct devlink {
 extern struct xarray devlinks;
 extern struct genl_family devlink_nl_family;
 
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver);
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
-- 
2.51.1

