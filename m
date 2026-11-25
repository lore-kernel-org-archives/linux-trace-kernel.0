Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650015;
	b=V2qxGvwkFJ6lXLVEocLJOOZWGr3qVBjtieVdFyQ/WSa2r5REyI8CQNxsNShpZerqMp4o
	 Z7cJpng3gD0VTTjKbREM/qYLVslbPuYYkpx4uzLSJcvzHyO7+bF1QSP37euBWLRZ/FwIr
	 ta19bWsPDn9DJllmr7yBsOBtv2r/6yqrcZcfiCnqPAIDO/vu10h1c0E8Z1rZ+UvFX7hOR
	 WwKEMq1YE6YIcM0aCQMR2o6jdpjNZoJ1NgUUGn/K2Ax1gdD4Q0bty0pdSHY4GOdqm2Ywb
	 5z/BtDiPBtviDSCO7ZZi5oqiTjfq3qhtUe7lMWaH9I0anec4Et8NyDPQGO5cJ+XTSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sy32AM7OWNp5QprjDSdpmB7KMgeEhH1/PrZNTOpYGSI=;
	b=ZPzUGakFhNGvQET9ctE6EchEyqtj9nS0Of4Guet62MvUn+yTOHiEw1TuXS6+oG6hmc4K
	 j1BMNYaC5IIs2OS2njHNkV/ckCQAWJLpiNVoGFTDYRNaWfzxV4LHVkG/100RbFkpIWbeP
	 +DhFhOovhHqIs8s0+m4ggMjZmEM94x/jKsm7KhnTdgdUksactwJCxki3STWQe5NHI47Vv
	 /wOsA9rKej44w50AygF706+3RIeYKE05bn1Eg58y8n7nlii8pwXNaAuTdFlUTl97nAK1I
	 hIsl0flXgeIL7HCtJf/uNwYAHsyV2V4WUWnlageuigZUz4uM69M5ai3wXLpSuriX6Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV7s7p48;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18505606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 23:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18505606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV7s7p48
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so41587225e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650013; x=1796254813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sy32AM7OWNp5QprjDSdpmB7KMgeEhH1/PrZNTOpYGSI=;
        b=eV7s7p48l0yWT+W7zLISJg0zwgqnRnYXAqaouqk6QzCcqvsKi6IQ6gvBcuKe3y3jEI
         U/gO/KkZKX7nPeIDHZhOmTYGTD8oQruIjejDeGJQDxIyARVwAQrCs/FnHVm/sGmmAtP0
         eFX5dWz7uBGLNOCvmKgWyCM2ClO6v7WccN92uBSdDZcJB9ka0iSXLL7CtikujSwRHEp2
         cIY/0zTCEpoqeUS5HCT4arF4+dbh4Cq4eUJep6GFwOXmg5ISC/0x7dIwRlH84RzMRLWv
         23zuRHDaokVfMqMEM4A4RU+IRaSC+ZeWVJGT4/7ym+U1LtsT87BzsfTP+WdFov4UYMZY
         8lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650013; x=1796254813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sy32AM7OWNp5QprjDSdpmB7KMgeEhH1/PrZNTOpYGSI=;
        b=yD9+4WMeWRwmWu7chXcRKYqZerreTOlExwI6B85KN2RZJU4JUF67L7/LZ/b5KzRsRw
         Oo6tLXDvC5PX703J0BbITyvpWgEPyaNzQuOSR5K+Yv3zE8QJX2wzpgKun5iL5MQ1iogO
         mxE+PfhfCyTnvMETR2sgVBsoV5hcM//fWaVYPChLS3r4gZp37NCE9874Nw3T/IU7oxBN
         VTt65r2/igf2pSSndfgLMnDTM8krcafSxUjWA8FP/FNQATnxoHvG+UsEUIbfp1S4IWz4
         LxmY/cPgU8UVOIbKxtEO/V8ewRnMo0B6MO1mT1qGxM9Fn2J4iuDwxraZHkwXnR/bkXUk
         9ieQ==
X-Gm-Message-State: APuU4Z/SpmRrwSHcU6whSk+WWnzY9UGR/MvXUhENLMw770pSbZXKJY0d
	jndG0DLMRQwp+fvTGQ6oxPLisRc1u4anuSe9MTU82oeL0aj9ae56pZ9COo8www==
X-Gm-Gg: AZFdTZd+YoNmMdUm9WsXw6p+ED/37SGrw8qQbX2V3QpgxD7umMAlEXB0eBolJtg29aG
	xVZpyXoUnE6cUDteuySA6VLb8Fyp6tBA1CugjCzXKpucSOjAr17Uc2U7iU6JhW2HO8ojUJJFs7q
	34fGxYCpoQu647wgghPkpXEEqTpR0PIu3pKWUxVoe9fK51UP4VHeDzq4L+IO75NlG/REQfvtp4I
	Ipfpl1o/4NIfKoekUYMOrgbar8+tWx7rmL2k4aMejyUwREZPhQ93Xd/1vEI6jBsFLNOcMYjyPyB
	gnxdolLnXZ/MvPxqHD/c2yg+R6YKobBcUWau0WDvoV/keRSBdxKZeqhCjItE1bga3TjXEabT578
	td3NNeAX4A2zjaFkHdseDbhRGyW04lxqR9g5uRzKwFNc2WufOHvbF1FhF4l4A97PYVVe3sUtJ3t
	eOld24spU0icJFvsNV1fFlwD8GxIoFF8NgEXsxuXgpqACr0AqOtbZzr6B+iOceryjfB7kv+6CiM
	EeUxGdiPoyWtZZnoCnivH+I2FgTwgDXLudDmBp/m0CrjfFPjGL6Xbt5BrrRfaXoLNaXgcOSSmlu
	bC6OUlUlckExHFPvUSvruI7J0+/nMryqNOwv/GDwPzaBDNzXbM8GStH+7wVPul4d/cz+hnkiRsM
	8BaFEHFFclQd3QNH6pjoMkLB45T8KgPqqD56KTQyLmHvfklExvuVcVg7kr+yJzQqEaI5fvJgBqr
	J4/2GAer6RK1dAmF/Up9bM//6psnF8goh42CwovbIublwHkzoUgbasdyykdJRPv3MmQ9PCyOhA5
	dwRYh+QOYDvHpXBFQNbHR4MunPapeY+CUIBmCg=
X-Received: by 2002:a05:600c:1d09:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb88816c7emr423168995e9.28.1795650013339;
        Wed, 25 Nov 2026 15:40:13 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-e77f-3dca-f235-969c.rev.sfr.net. [2a02:8434:fda5:4201:e77f:3dca:f235:969c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm42466849f8f.24.2026.11.25.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:40:12 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Reject extra positional operands
Date: Thu, 26 Nov 2026 00:40:04 +0100
Message-ID: <6e1358cefd6ed85c1c264cfbe195b913a8a0aca1.1795650002.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bootconfig CLI accepts one input path but only checks whether a path
is missing. Commands with several operands act on the first one and can
report successful completion. For example, bootconfig -d first.img
second.img removes bootconfig from only the first image and exits zero.

Reject surplus operands before calling the command handler. Add tests
for list, apply and delete with an extra path.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

I ran into this while checking how the tool handles more than one input
path. An extra argument was easy to miss because the command still
succeeded. I added cases for list, apply and delete and ran the full
bootconfig CLI suite on my Ubuntu machine.

Thanks,
Eduardo

 tools/bootconfig/main.c             | 5 +++++
 tools/bootconfig/test-bootconfig.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index c85e58fcb6b0b7..3e56a618fe3a58 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -592,6 +592,11 @@ int main(int argc, char **argv)
 		return usage();
 	}
 
+	if (argc - optind > 1) {
+		pr_err("Error: Specify only one input path.\n");
+		return usage();
+	}
+
 	path = argv[optind];
 
 	if (apply)
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a93a40d11d278f..ac0ffeffe1f7ce 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -71,6 +71,11 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 echo "File size check"
 xpass test $new_size -eq $(wc -c < $INITRD)
 
+echo "Reject an extra positional path"
+xfail $BOOTCONF -l $INITRD $OUTFILE
+xfail $BOOTCONF -a $TEMPCONF $INITRD $OUTFILE
+xfail $BOOTCONF -d $INITRD $OUTFILE
+
 echo "Delete command check"
 xpass $BOOTCONF -d $INITRD
 

base-commit: 56bb11fe6aacc7666938e8e6765b44aa0cf1fcdd
-- 
2.53.0

