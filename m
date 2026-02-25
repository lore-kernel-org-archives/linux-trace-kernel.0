Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B63B9613
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026471; cv=none; b=qE30jzIqpGx8Cu6X5RSLW01LvhQASSswXqsAfJN/J0cEytcdqbQqpDuOSirjCqsm0qxj0Yu+lcFWGxg1qdAcnQJyanZvTC3oNnmCYloW1xylpGcSdXLq6e8CwWxwBxSarHK9LJZfOZWy+yvV8JHpeKd+5DGNh4tvIQ9m6poDCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026471; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRCOcZQYGN3bBwXvjSJNY9a+cdvltINm35g5RXmEcdLPFAAJjmhSPuo3iltepnvDQZFAUsmlHm1BzW9VMGFxySTNgD6ptu32NMo8dy8DnN3MCsq4mAd75AYxDm/5GIg9ZJoc5ClQa85kWC65+R4wo/Iz1/8vTsD1ZFRKRT1KECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BczRShrX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BczRShrX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48372efa020so53796415e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026465; x=1772631265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=BczRShrX8kFKRl+NNC4TUU3fx++ERqfTYVffd2fsSe3xeCriS5DSeUmMKdTEoUHysn
         X3ZmaSXJAvzF4pgV3FkHk6zblNlljRC6aT3NchOHj5J+Li0ugawnQgQJxtIW+1BMcIBb
         SW+vqRD3kp2jz35omeGV09paNT0niPtgU8DleEUp8UuuJywTRQJ1QiZhFlasAn2Lmdoo
         7sIg9/E6661RsgEERrFVhNz0un2Zn7Fiqjv1nu24f2Oq82fYVg4KsISULKTpJsjoWf8D
         o+uHzcud1eTMY3KlqGXr8WPu25QIkzJAvuiy9xCOUTkCoXWDPim8C0gJyI2rgdym+r0z
         gKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026465; x=1772631265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=Jh0G5WmTvj12B39msfY48fZzuT4XOcza+HNsGq9fpYKtdxnwMLAahSLrfbebfe/UB7
         WdFL8/jUlaRKIUcqsga/ep2SotUXdwENTXCbqXI4GOV8Ck/yh7bFNLYPAfZZe+7/l6AK
         1yFIg2Tl4FX3xZqr0742B8PWRcCO1rJbe8RFrx3CecxzUrIEHI0msNjG6ygcQ5Vs2R5c
         bMyESXtYyX0Hwlv4B/zN0Eials3UhVwbO29PILse4iATtgZx++wmC1b9iCxnrw0VpWI6
         LyZsFSe3bOjwMuGSszjiJj/VGmDpgSkIIGUUSCn5kTsCmPQ7ObYBIeNFD4Gwpd/FOwwT
         CUMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5lHeau5vpMGKE+klatQ2Lgg03aVq+0iNg9MouWud2ebaEc7uikF0Fol9Y1ruWnqK6RtYmGnBq36QCxZ355h2YbL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PvJ+SphAAtIFc8j3EvovTy09dy5b/XDmDkgAa7+7ezweiSYJ
	LQyUxa1gNYFIF5L2QwLsrg9cgTueLaXwjc9LmnNbFyPOAzM5D5xRCi8B7pfMMhS+q3E=
X-Gm-Gg: ATEYQzydKVM9T6sSWvHzp8zWWWcy2q8VZWSOPRpUDPxC1SAx4D9g3R+NDSvz7BFBXst
	ttllK7ch+Sy/ekohJM7Xz1WGtAP3aCh4UogTyQdEH5xCFReQCHGtctvytwbFAPORahWbaCxGb5g
	zduusAaeNOl5ca6kSqddJlmDJ1ZjwptqXXKTBAUn63cSEN6F2PMqok1Z/JHI/8YUpr7JgR2fGEi
	9EUQrMwo5ctDSO/sKrI/puAGfreXkxgONYJJeDWB5tgy9cF26amXdkDA06w1JUgEvT5YU81ORb5
	Fn55JWQBaypsbuEkow37Wu5ufYv+wZeBN7bFUO4vUMR64/4wctYQ1lNz6Wk5GkZT4NBZTG4199U
	jf65pAlonRIcP0fXXpg/k0AjNlUlcgVWdn/z/kF9Hc9eeF83hJOwRmNlypIciRY+qAAA8BM2IO0
	RCHI6j8wTQqjN5DJBcI6rFoLB9
X-Received: by 2002:a05:600c:a11:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-483c21af52fmr5939965e9.29.1772026465278;
        Wed, 25 Feb 2026 05:34:25 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776a3sm16744665e9.7.2026.02.25.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:24 -0800 (PST)
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
Subject: [PATCH net-next v2 01/10] devlink: expose devlink instance index over netlink
Date: Wed, 25 Feb 2026 14:34:13 +0100
Message-ID: <20260225133422.290965-2-jiri@resnulli.us>
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

Each devlink instance has an internally assigned index used for xarray
storage. Expose it as a new DEVLINK_ATTR_INDEX uint attribute alongside
the existing bus_name and dev_name handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 5 +++++
 include/uapi/linux/devlink.h             | 2 ++
 net/devlink/devl_internal.h              | 2 ++
 net/devlink/port.c                       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1bed67a0eefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      -
+        name: index
+        type: uint
+        doc: Unique devlink instance index.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1311,6 +1315,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-failed
             - dev-stats
       dump:
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1ba3436db4ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..31fa98af418e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 		return -EMSGSIZE;
 	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
 		return -EMSGSIZE;
+	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
+		return -EMSGSIZE;
 	return 0;
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..1ff609571ea4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -222,6 +222,7 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 
 	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
 	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.51.1

