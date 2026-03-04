Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D934B1AC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640031; cv=none; b=q3FVPTkVhlUJG/637cAakrkybOTMWz+m4zve8tWzQm8NFOVTpLdRbfg+oN+/lns3uAaJoRUpWL6kozug3N6vo0pQZdmkbfo8hfY0JJ3qxNjPG8s/QgTR9Ps2bgrJINv+VaEWDiIhfFaLYczwVgaw28BjEuPlljWgvm+CsF9WYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640031; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5mIk5EaEvX8dNyS/Ee+o3HvsWBhd6MhMvU7aOOOlqPLr8Xiu/qsSl1Vzs9GNHF8DXo1MJIbtQxkS4OhWmlGRWvu1GFM6lH9rANMzn8rYxAW1AkuUb28+rPuY4+9kk0ZpT4VGAxOnFhit/cSP3xnkAv0aZ5ege/rZ0u89QM5rUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xpNtugTn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xpNtugTn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b78b638eso3617720f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640027; x=1773244827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=xpNtugTn5UkhZ0Lnj1qvpN3/EWbSA+Q7NtWSKHhiGKB85+u05ycJt2AN9tUrhAORh7
         hW+ribiQId7X1OKVlILOHPPh4w/TmVWNbsisyRB6ffJ34Vzazuplk05LwzGI7PNAcl5U
         a+zA90aBV1Dozsn2xQ19lB4SEP4M+3LvWhRAskqdlKCT2/49kNdf0633Cpkg/jpF7ntD
         SArn97nrknD8YfUqpQzAEJI/sgPJuRxXcFyCg3EPGuM0NLApF2sp1c/MBKdGMse3WcGY
         E/WNZK7o9QAXHrQMSZeTupaT9WPkuOs4CHpV8+2NziKLbUHnurL7UZwLXH1a6c2g1kH6
         9Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640027; x=1773244827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=bA+CkTRt+2smNhUYvvzp/FYouS29UmXWELBn++Myqy86occVGJ6JXIhwxVJlt3JO+q
         XbkuNnUeXt2hok9wl7JDc1UeSv5w1K8Bq5kjSxlX5wTPmHAcDW0Knc9hjy/WfW2b3b7Z
         eQQMX7aUdGtqj0bycTU485kPxRS/18R1bbtirLcIooUVsKuMnCG/km3f2mr5YNAisv9R
         EhWyrRASvhM8w1n+D6cV/NFxaFc9uFHwBSEHW01g8f6e8HVW+f1PqrMRqRrUVEcHmvWx
         REj5FZx4CSitkfyRISIxTuGS10rr2P68vmTUYvNGnfc+37Ap/zzA2jRKyGGyNThdbySy
         kyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGv3xAfqvJj8Uwl8m5i/kOCUNl6sCajSNKTABx56wji6C+2Iqioc2EG9gSX/QOsmmxKv3GjayV1CWA2TVuZj6HFJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlnBvRJH+RvEMCoqJIe5jhceD5o+FRCdFZBn6/0K/tgb6k+Pc
	uln9nouz/fpwdji95NJsTDG4vHu05e59XyQwWL+MN/ukz8rHbvLRe0DP8MzWNJ4y5Hc=
X-Gm-Gg: ATEYQzxKN61k2bvhJR6DUhNcnZ5oDrYiIMObLUop/dewLkiw1UJMqFa6ViFasURheTS
	8l7mggBCsQD/oZHhAuE81pMeyua7kfQF7LWH0broW9fkvflqpRlOg46J/te84MVrJjYfi9S+RgD
	F0wZmbuxS9IGBeDfRXxXkdqq6srQx5ci2VJ0z2bT+HEhPdCJ1ZLNMkzwXUdreOK1iQ79cSECT3y
	zVdN7wOuRYNEco1Zai/BbJjccdBE92p1KxKMn4ZAd6aQbq7kdaSSfR8iDKgWG4h5o9FsV3UIkrA
	CmPN6LGJJvp7KYGcPXPzNurYTVYefKd3gr6RWWhD7lkuFI+D1sHzIe9eiL8LmSjns1UfAD30nZN
	o4xKAsWzNnweF9KKbo7l5RFkFE20mCO+jtOVr90E6dsUZT00myhUYFF0AiHyPjNAF58ZnFsohWk
	52or+3BIfrDJyNN3tcxdw+vyiLtepHs2qjNop2+aPDY1uJS16ZQR7JMzNU
X-Received: by 2002:a05:6000:4006:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439c7fe3d7cmr4503831f8f.39.1772640026687;
        Wed, 04 Mar 2026 08:00:26 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm27629409f8f.39.2026.03.04.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:25 -0800 (PST)
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
Subject: [PATCH net-next v3 01/13] devlink: expose devlink instance index over netlink
Date: Wed,  4 Mar 2026 17:00:10 +0100
Message-ID: <20260304160022.6114-2-jiri@resnulli.us>
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

