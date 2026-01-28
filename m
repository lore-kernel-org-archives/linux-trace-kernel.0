Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E298308F05
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615309; cv=none; b=hCUgvtIllbLJzy4Lx31XIPxBWqoVjggZMdqEVxbKrpef6JBBMvj0GyWSNEfTBUBclIshBag5tCiYq/FlDhiC5pZB130DMD4nkAUoCqZiWlcf4kMltmmHbNxew1DKbfkTlPT408FuJIun8mEOsSf54vbcBN/foesXuzYWWa1GYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615309; c=relaxed/simple;
	bh=CA4ugjQ1IEjW+6kqAc+hYZuO43p3F42A6CJda++BPeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b9FTTG9jCp57ifgHxfZqdhTn+f3/KRMDRlnqy7v5Ophd3snmldBJsjr4lERRl2LYosaPoKK6jchrLib/RhOCRN+yOnDmwDOavUqiux90/xfEi8AToWOL1gL1hzRVICAwH1jsb5NqFIy7knA0B8PgW+BanF4zA296rxZUY5yxc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VnTUrWNK; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VnTUrWNK"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47edffe5540so81680765e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1769615306; x=1770220106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3QlHqlhG5snnD54r/ty/Upcu15CQJsVNvjmcANqrMA=;
        b=VnTUrWNK+u4mdmf8BxqANcric5lPEz10y4sWg+SlmsNWzPgPziMSM2tOfexqLCFksf
         BTYfAF+lyYgAcC0vmNMo+6zzXQ3cZBTNH3uoUi9dyCqyMKb3l8EYZQyA8wKPj/QTATMj
         fdYN9ehwBAcPadKbGHqS66WWAz6ALY8dRpPOzngdaCqyVoNDrWQdd8RRtInDYF2B1GuM
         0J/p2ga4NuJniavwwGQA5ttZiSChx1gdu3N5+J/Cq67xvr1kb2JJq4y3z1wvZc9YFaB5
         /9eHvth5D+RpdREO6IVDX65JDqYxNykWcWSX04VhSlchKLuKak6Hv6GVwEcMFCLxnN5w
         C8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615306; x=1770220106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3QlHqlhG5snnD54r/ty/Upcu15CQJsVNvjmcANqrMA=;
        b=lsLxXCs+Hm+FiZJZlEMFCTq4WTSF7OWzl8PFDr+wUbndBYWxJ2+NCEEWOrfvmnYlx1
         T+f6s2qPT0u3XZUDdZa6sl+GL2/BIwiXe25P5QyBzp4UKNwY4CnYbfOKMa/waxzL9x9s
         ORgymb08XHLbpwHVqF8zyWKt6TpmC+Q5NLzLNppss0eIFCrQjrodS4ZLcOvqIc2F5pz3
         g36t4IJwj1fc6f76DWleXv1Bih8b8gmJUowpSWY6cDHlh+MiLnYGlyb2fDsrpmWOk4QT
         mfsItkFCxAFwetaHtu37jyivdTAT6Y+qWpcys10cwlgU9+lua8MVagE+AzFk8svLYEbB
         NUWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3WKFffeFUKVlE3dsHmTjg6wGDGzFwYSRc9dF1G23fMAnuli6mTj20oofk4ZB34Zi5lu1kVX/k0wdgOKkkDxdvhz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCGkF+MEreNVGEKCC4LUh5jbWmS2g3Ftx6PKmosdlNZ8Moze3
	mj2+l+HMHbNUKUlB6fLHx1QEO/oEWK2/tjgmInsedcDR9asC+GOvD/OjZybxAVz09S7sXeIUGYw
	FNvUt
X-Gm-Gg: AZuq6aKnMVlyMS8Ta4bpWuQzkEf+cwEQ1vsPLKihbh3RNsUDxKng/4bY+oMPlluD4ft
	EzMJqRdNlPPTjwcBAssLvEAXY7XQ31Xv646AXkdDkzTr7o/RHHxqN5cwtnTXOJs8vIfBRER59hW
	PT8XR8oQTvVnBAKLxIMxQqwCggzu0PYuwmwhxFtz4Hb3Yl3uU9xcEIC6lqttBHARtEtj9zx0JZ3
	bCnhhTzvBTyJVT10QMIgTXtqBkXRmi/QFKAHiGVTRwalcxJLnsNTdz6CcwP2dUazD7xI4i9dkpX
	JFmW4lOB7835p6USpbRSubdu+ZdwPo+KEkWBy9Ad9F0F4veGcJhNCr3zimM9bsLH9al43f401Xu
	rpMnLdRuymPm+MWCXNdRwVl7+HOflaHCUUOYh9+nTTz/mvUrFgDpZWFRiZwpHrzXFVpTCbqHVnm
	HQ/DUmZkMYmClyRr0EKtrUhWvGUd0xE6f/hmKaBhpfJgFkEv2g+mYcDIKFXCa39LDBpGa9vCKaa
	TJA5a6IXyuPxSHJDvAP05HIOvilHssJSMC+kw8YHkeRH3T0o4qQwvTM+y5KFU+qlsnoiS0b
X-Received: by 2002:a05:600c:4592:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-48069c5b97cmr75909105e9.17.1769615305735;
        Wed, 28 Jan 2026 07:48:25 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2bd243sm2394135e9.11.2026.01.28.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:48:25 -0800 (PST)
From: Daniel Thompson <daniel@riscstar.com>
Date: Wed, 28 Jan 2026 15:48:01 +0000
Subject: [PATCH v2] iommu: Fix NULL pointer deref when io_page_fault
 tracepoint fires
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-iommu-io_page_fault_null_fix-v2-1-de047be6dd3a@riscstar.com>
X-B4-Tracking: v=1; b=H4sIALAvemkC/42NQQ6CMBBFr0JmbQ0dsSIr72FIU+oAkwAlLRAN6
 d2tnMDNT95bvL9DIM8UoMp28LRxYDclwFMGtjdTR4JfiQFzVLmUSrAbxzWtnk1HujXrsOhpHQb
 d8lu0pWwKKptrgRdIidlT0kf+WSfuOSzOf463Tf7sn+FNCimUxdwiKbyXt4fnYMNi/Nm6EeoY4
 xdRcdl9ywAAAA==
X-Change-ID: 20260116-iommu-io_page_fault_null_fix-f81b4e8b5423
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 linux-arm-kernel@lists.infradead.org, Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=CA4ugjQ1IEjW+6kqAc+hYZuO43p3F42A6CJda++BPeU=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBpei+7xn8ZZiBl8xCqnIgD+Ld8t+5lgqTfxVf8h
 b0Z17Jume6JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCaXovuwAKCRB84yVdOfeI
 oUZND/9RY6F29ijnSmDBq/dwsNlREV122MJyeYlx4yZcygd8sC8B9fW7nagoG+zm9asqd6Q/ziS
 Qbqy8zqxoSs7BdtyvqAfKJkfGw5eyGxI9XTwVUqB/yskBEM2JsNzWrNID9Wm3DK0ciLG9mSwiyO
 EJu1ql1Fnfc/oPvMFs/xIvweP1qM2RT0ka5n58k9tSBdrkMcc7AtURdHuMzAjMqRJQEgDAp3gB2
 0In2j5f3rmL6xSCcsnpMzKdfbO7hAhQREgqhVVhZZh6evXyCIjySls7oKz4Z/bFqgsahNWHJn2i
 qZY2ck6xR/AssS7XW9MgR622bTQukQwqRhBcuVTkf47jGUr2Jygbh5uBs1l+JnjQRi+mU2gJ3L0
 TNO6/iym13M0gYr/4lsOKlfGWHI+2UWnvN2+ZHJdnbzZ9eRN1c55JjWm7d3NoM1wC4kFQGKNfau
 lFoKbRRWK9V19X2k5nSH0wWBMHC+YL5dX8nTN6LDprE6bRQO0dsT/G1aI4RX0te4gA+6Uw1je2z
 6RBWq6/GTYwms8r/AmRNf8BYnf5CT/rJlD9zlT6J39JyKVilRh5CbaCGDJSv1lTwPluB7mZABlJ
 a7zaK5FMnNesIsc7YwPA/LndTRCDl5A/Ads59baINuKBjxYB6aOJexklSQmdAG/FZ+gPB5t7pC+
 jD/6TD1uwuuG7uw==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The arm-smmu driver is unable to allocate the blame for a page fault to
a specific device so it calls report_iommu_fault() with the dev argument
set to NULL. Normally this doesn't cause anything catastrophic but on a
system with the io_page_fault tracepoint enabled this results in a NULL
pointer deref (resulting in a fairly spectacular crash on the hardware
I'm currently working on).

Fix this by adding logic to the tracepoint to safely propagate NULL.

Fixes: f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
Changes in v2:
- Add a Fixes:. It points to the earliest point I can find where it becomes
  possible for the tracepoint to be triggered with dev set to NULL.
- Link to v1: https://lore.kernel.org/r/20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com
---
 include/trace/events/iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 373007e567cb827458a729b8200bbcc1b7d76912..1315193f13b8812ad4e29e6b0c0c66ca806ce08d 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -131,8 +131,8 @@ DECLARE_EVENT_CLASS(iommu_error,
 	TP_ARGS(dev, iova, flags),
 
 	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(driver, dev_driver_string(dev))
+		__string(device, dev ? dev_name(dev) : NULL)
+		__string(driver, dev ? dev_driver_string(dev) : NULL)
 		__field(u64, iova)
 		__field(int, flags)
 	),

---
base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
change-id: 20260116-iommu-io_page_fault_null_fix-f81b4e8b5423

Best regards,
-- 
Daniel Thompson <daniel@riscstar.com>

