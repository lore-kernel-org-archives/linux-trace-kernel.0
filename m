Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345363BD64B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309855; cv=none; b=G1MfoJwkhehqL5UZ0IMCEzPSuIC6TVsHLgaZsJ6Bpz+c9Pafv60Dzs0T50w20r9H2XY+jAITKrYobXQgSCof+ds1V+TOpn+HKQWx5ogc5EWh0mgyUEmQ96EplKtMwNF4JD/MwAzhvlkyRCejF0DD/geEcpQmSXDTYxeb+aA0mSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309855; c=relaxed/simple;
	bh=Vtm80qE6FuR56bwzyqwTxutZyqLSGPZTe2b3PkwM178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3StECO5Wj/5QayUUi2W6CiiKZ5ZdChoNcnP7SP8DWVvEcCK07LGd063zLNc4aT41TDfAt1ZU4RROYeuusSv98CCfbTo6Na4Ckz8u9qab1Ezf6aTh/GhJ52f0DpwdFF5jOWQbnyi+ramS4J9YuKdtLx+JimwkAt1+Ih132mYTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UuGFrvqL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UuGFrvqL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485445e80bdso7044335e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309853; x=1773914653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=UuGFrvqLIk2QH17vam2M68KVzf4VxO9Okf4knKwat2Ghw6FJ7A4oAd1vwOtks37Uz/
         olYnXO3NIUYECNqFEbMrULA/rKd+DMX+1LM0KJlB/vWO2xlL5UwOsT4CmmVhYfFc90Wd
         JPtb6eP9wLzHKPOiazn+gr4DCJtiDm2WAyLffki1EwahEsfo20F//LbPU7wWbn5KDSOQ
         5smyc+m62FrVpBUl7FbDlCFbDb9tq7/r8oQHID5EPeXhCs0CkEuP+fT/UC3ES07v9unw
         Edv2a2TzrEOA7CYxIguTkXJAZCjLGXJ6gu8Ez5sQyyQAs5yY0TXKtJoim+m+Juls1B6C
         ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309853; x=1773914653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=bTJ02uFLU5IHGtEedt+/wFpRvi/C8IvCG3vL1mEy11eQqtxIA19JfxdOhHputxCOTA
         Bu0T2xHIvilNXy/q/k/AaNoEUAwExOaOkq2M9eu8NzwkE3CACZgaOHiCO+MkPJSWgVDX
         XYhOSkuXJw7BG3CyX0Gw3t9x+fKDItYhm026AOAYnnkE7OcZgG4mAnnCrULjpv2L2gEw
         HOz1DM553myyaIP1mbsjyGbGXZmWro1AkKGwS7tkCasYjBRF05QUobdCFdhuSuwmJlIy
         wg8dGQcRYMJ9w5CYxHkmgD9VJCGpu1RztQviO7YFrenObh5u3aU4gW6jaMO81Iy2YDW1
         O+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUIHGUMmYxLuIdLEAsPEr3ZvTWVxZiwerRuOruL2qlTIQ1aDigH4a2P//yH4aIDes62nbG1l5vhtMnARQ2Q3JQ3K14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBY3raB2lrK+7b4ewm3yEcLBNGxmrOpWPbDOnUN4KatylxLot
	/vp6PMP6M5H5xkQUhvisSM7s4F4aGtxgc/ZSV5wkQGD8HRoF3Tj7J+mSzoMaTmk1u2s=
X-Gm-Gg: ATEYQzwcvKO/C7mCbAepK4hWH9r3U0LP3Z4Ujg56TmaKGUg8ta5Wc2UecBbgNrhZKP2
	CV5O3pLSQIsUPAzch5ykwpD1AjLvZ/PAn1k2pUa6azaomgVSQnzLWrNvzvMFIGMKZwe2tZ/L6D+
	f2nDK1E6G1PvjEe1TUAOx+j4vz87Egok+LU6nyn7373A8QLSoII29b6eOLIasFn8xZBKUzqUlSL
	CBFpoqmiGUlzpKLMihBn9qdbvJ/mnbW34IA7qQrMtYztqPPeKaE/vMUMcS1DhppZa0ObNeDjX5h
	wpz2bsZLgoH7ChsSQjyd+pXtsouTr2EvJ1TSSulFKUaZWDfcMx/6AcCrRyiy/IecOhUJS22ixQm
	GCTpPbPVd8aCYhLBdRVrsZ8LnBE5+JMljCZ3rtRbe3Da1xN+HryH4KyEJ39ibzyoGFCsLNiipW0
	MJ9DdwXrwHHhjw2Q==
X-Received: by 2002:a05:600c:458e:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4854b0ac93fmr85263525e9.1.1773309852339;
        Thu, 12 Mar 2026 03:04:12 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm304199535e9.2.2026.03.12.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:11 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/13] devlink: avoid extra iterations when found devlink is not registered
Date: Thu, 12 Mar 2026 11:03:57 +0100
Message-ID: <20260312100407.551173-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since the one found is not registered, very unlikely another one with
the same bus_name/dev_name is going to be found. Stop right away and
prepare common "found" path for the follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 56817b85a3f9..7b205f677b7a 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
-		    strcmp(devlink_dev_name(devlink), devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink_dev_name(devlink), devname) == 0)
+			goto found;
 		devlink_put(devlink);
 	}
 
 	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
+	return ERR_PTR(-ENODEV);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
-- 
2.51.1

