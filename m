Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0F3B960B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026473; cv=none; b=uaqtNJC4oa3Gs9TBtIxZpPPuhEvKOVhMBaXTijimx00WDrEUJhoDKtXpWzu2sp5hB1DgMt9m46X7e9e78Au4IMujbBllDrfw87UQYMWQip8VPVIiCCYsMfnvQb6XPt3frwv12ZI8ZpjDxKK+op08S+4AttVkfroXd7L4qcmnA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026473; c=relaxed/simple;
	bh=cBdk7OS/MqJvfgCd8WjMOg+aNCv6O46a+gTZy5CXlts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEiDfLxk3N1r8XfyxMuUvJLORXneLaB5S7WCEJPcZ5NrAjkEr6M/OF8jmbz9HlCMyPZSRuBiLsfudvk+kN1TF9U0MHffYQUzy+wx2eY9n+H5+39Du2e/X3xQtcqiPGoyWMPdZnSOUlq+iXMSlXDStLewhTJZSZsrBxvVAHJyDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xiSL6goO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xiSL6goO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so57312725e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026471; x=1772631271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=xiSL6goO+ydywZ0fzuuyNAZq1mr+W3T+rXTnZaW85NBrwDG6raKJeZYgcNGPahmj8Z
         t7N86d5W0jiAt1mO5RM6jsIhTyDFR/mu5Jo9Fv6IMAmrLR3E0DBNqsY1ns+JwnTsdBKt
         0ZBjHt11fdIv82tXTu4UrNjqQVP8mH+sYTbSuy46ekEXtkCtkR3XN/ftgV0ClX06zHu2
         dBxUbUPq4d2ePWfZTZwHbIJsyBjO0+N8gv7bhmc33hKRb2PF1jIB691AdO9+Kj66ASqB
         dMvSZmrYuHsIo7o67ryn5C85snUmXazAPbFp8ccEGmcLFhlXdAgcgYr22PG0wV7vBSi6
         OgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026471; x=1772631271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=gl2Cag8sUFjqmDGkn+NkdGmtTYyXLov06fJ1CPGjlxBbiV4tgWtetS/s6Pn9FxqZwe
         1P+jTlmwT6OJNxROh23m+ZLkb6yd48HXf5Y4AS2TxfK4Oj5Nuz/9bnKfQLXmvw4RDcwv
         BjAyf5L/FQ32+ySGJ/CdDW7aG+CE7DWcBS2lX/UpeA8zQ4bPvhZRUU1lF16zXhIse911
         k5ntI464ZP3/pgddzQmja4gYzq+nMe91zuPmjdtTMm7qYFY0ejsopkbgtkwz/Ra1OHUF
         aXuOeIT2zBzoV7p1Ny2i0S0wImYJKmai+ZqbAvcuyNjSNBZPdQAbBM2iE33Z3M7VJbzX
         ClQA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYmyZlRJoNDGpDkGJo31iH1VRZ8XK/8UOrGBRiOAhamqZz78ju3ap8PlYiAUIJHoDIu6dIFMnv6gRDlxv0iLerIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2e89S5vxgzbxk9FW4cY00L18FFfjsh4HaJCM8hwzSq+DY7YHM
	sCIpx4WBmhQyxZPzTX05yOAH+ztkH+n1/a6+AFOS3vSCI5LG9cXeaUs2WnYDe9qgWZI=
X-Gm-Gg: ATEYQzznnXgFAuFL7BvErVAk+y7lG1h8Rdlj/tT50VZy1qz2I9A2RjjLox20n0B0oc1
	Qd67tysrv5Sj5ZAIq1UA2mLcdVbbPQo3/pa9lF1uLggbrw9KFRfj1El8s7Ql3biMIcm0fDpNmHr
	EHGbhm2/PAKCygHgz/DTMnzSDMf41M2xvzJJNxb9EgwnGuKfyJiaOf+cgrRBsQBQAyPjRaJpT+O
	fFB2detMp8hKZCMprGk+s7enBwv32gaScg02WtMnJVtcDmr/No5dJ+4y+O1jI3DWfos52MNnwxH
	hTl0bMlv5f8Amy8XyDnVM814iS6rJmY18nRXUf5X5lCxAtVvKBT866TQLqge91PuFTbimwhqH8J
	zR0nPAo7TUz279FUr3Vd0J8zO8M8KmvvOqe5BeKAFozeQ2mppJ7HZfJshRt8IzyVM/HCWanYRDe
	tCD3e6F4gnSL1O4A==
X-Received: by 2002:a05:600c:8716:b0:471:1717:411 with SMTP id 5b1f17b1804b1-483a95e9a7fmr276220965e9.24.1772026470590;
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm18237565e9.3.2026.02.25.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
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
Subject: [PATCH net-next v2 05/10] devlink: support index-based lookup via bus_name/dev_name handle
Date: Wed, 25 Feb 2026 14:34:17 +0100
Message-ID: <20260225133422.290965-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index b73cec31089f..127f337489c0 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -200,6 +200,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-EINVAL);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
 		    strcmp(devlink->dev_name, devname) == 0)
-- 
2.51.1

