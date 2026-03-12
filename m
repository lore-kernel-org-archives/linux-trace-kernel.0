Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802D401498
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342709; cv=none; b=S9onCrqrYp9TrLB+tigr3GcnQjPwe2BVRbfT44kbH5Ru+Ed08h5x+WxOrhtP3QG5gYch/yuzeU5t54EFOxDWswCAkRD0ZwUMCChAlX5Sr563x+qylKWYUQspJIHVlNHS0vDT3aCai4epw9V7Y8oLBRWrAhi6kyRX2+l328NMnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342709; c=relaxed/simple;
	bh=8ozz4uX3VG7ubKIGiEygr7D5oPi9gmvKVCXRz56Np/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGjNeSbF3BNJBFEjhZyYGadJatrtAeK9z87Iw3qr1pgAnUowtoS56MBGDVhC9H5LMt0MnFB6VqYnA6/vkNrEFAWcpZBa3wmVRQsBZ97SeaUDcKKPQm6agXA+AxrjXpD2f6AD0nSkYw56g+VAopcDwF64X0Ekqirq1hHisJTTZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYPe+GOw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYPe+GOw"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so1709812e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342706; x=1773947506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pyq/Z2cW6Oq5zvXs1uq6RW2e5g+Ci/r6rp/HxH6Mjk=;
        b=DYPe+GOw+pzfT93KT5GOTQ6fnxFWSaum/ytTv6wNpBjKWizgSBBl49cNcUr/4bIK5K
         Fbd6MBfuxHHPUhNQ4gdWNnzUPKemvxHMJYzmdNM+KjImSGPI9kPUal5KoviGQRoaQryQ
         2g0RiNGHHAsisOeadbY3JbUIZR5V6olKijqhvtyGMqAhsDTAHV6wGXchK0rn2owxTRro
         FoypZj8lD8LPQCT45suNU+bn5PLvFpdysM07AwBskHAWFH0vHMPJ19fxBX7V0Cj6hGVK
         bgoPUYq4Z1ko1lvJORGdmG2pRk85zB1NjwZ1aPW7Aq6wPVVEukvt0Sj5LKuBZ99Z+PUA
         sMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342706; x=1773947506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pyq/Z2cW6Oq5zvXs1uq6RW2e5g+Ci/r6rp/HxH6Mjk=;
        b=m+F1m7W9PsYmJ4BcDdsKVvA6ixvdj88416gga1AHId6yGkMc7HXrjD5ZIygA8rE/qC
         ncLDySJmk6eua0ekvFObMth9rp1vJ2gMavHni5M7gl3ci4Tp/mE+5QKTuEQ5KNt9Y4mP
         /aHNmr48q1tosueWwYcfVhPB2HaE2tjOJqjcCFhMhtZjFYaWBk3UKcsaGbzZBs3jOqoR
         JxPbc/7MsqWNLpcug2AjQhQ8BJ+e6LALQJ7xpfdU1dK9cuReca0+gcqbNLFNfBwWrPkR
         HG0t4ebAwWGSIceVs9doeJenvugV7Kaa1hwyxDkX6t45QuNNLR+E/utCTNNyHHD7DVrV
         2vrg==
X-Forwarded-Encrypted: i=1; AJvYcCUC3Po7IvuG1Jf1+sYyKcMaB6W9BgUnmu06r9oNjTlGmJ5XNdok+AtKkdEv8blC+w+d4F1/ofFPGrgJB05qbTWFEL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqsZbfLPhlOrqktV9pdYPXx3h6DQHPCGUMXCMStoOh3uHJvEa
	eZz3L/bcmgf45XfJu2/i6i1YbU2/pxxRWxYRgiiYNSe3YQ9vM3ZGTte2
X-Gm-Gg: ATEYQzyD1SJctyz6t3WlPV53+O9EEjhKeqGxG6hhelRHTLctTEcX20a6f+SbGsY+SNm
	HUk5pTLJfh4sFXr0TXxMZgLJGYXW6Ve+N+CLBFLV/7sdDz2Wzd/B1elJH2C8ihQmtcOisYxtfYq
	n5/rwXYO4yjgSvut+1HKV1wAEQhen9ljzm2VXLEQooH9FAtrvMxnwLOCzwzLPK1S/Csiaah0KMZ
	0ao0LeSJs7bGacZ2okeZK3DaeM7DPsUnczjYs0PyetuS5qCa5w8aB6jcfzZMJT9ughpGPtFcZng
	NhrhMx4XkFGyrXPCSAj4jlJ4E1mR5kv7vEQzbjD+BNAIVGImud99EDn4GtQ4YbdyNfFY/oRSivK
	8Er2veKNNTE7H/oYfqbh5e4I0DwS+zHv+beW0/yR3vbbpdoulER2uKOe4mF6t6yRyvmbT6Wozls
	RRCOVJg0tBYQ64eJyoGI7FhuoRa/kBg0I99I8YEh4hHtmjIsLuR+uAqrfHZIr2abP0sttjqXM=
X-Received: by 2002:a05:6512:1413:b0:5a1:3561:de7d with SMTP id 2adb3069b0e04-5a162b39c97mr153329e87.41.1773342706113;
        Thu, 12 Mar 2026 12:11:46 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156375198sm1112249e87.88.2026.03.12.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:11:45 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
Date: Thu, 12 Mar 2026 19:11:43 +0000
Message-Id: <20260312191143.28719-4-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312191143.28719-1-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

snprintf() returns the number of characters that would have been
written excluding the NUL terminator.  Output is truncated when the
return value is >= the buffer size, not just > the buffer size.

When ret == size, the current code takes the non-truncated path,
advancing buf by ret and reducing size to 0.  This is wrong because
the output was actually truncated (the last character was replaced by
NUL).  Fix by using >= so the truncation path is taken correctly.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 62b4ed7a0ba6..b0ef1e74e98a 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -316,7 +316,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret > size) {
+		if (ret >= size) {
 			size = 0;
 		} else {
 			size -= ret;
-- 
2.34.1

