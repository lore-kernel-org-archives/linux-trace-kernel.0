Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE221339A4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961143; cv=none; b=ZZNLma/UalmcgAQjPz6K1TQfAMgGm4VT/juIoPEgllsxkkXJNywynjxzAx1aOiHIoFjt9JOBsBBYMjD3ZalC/c+oDrReHvdNmbxXWcqqYuTFkj2bpax60P9Cgv1xe2ZU0A8UqSiO500zQ1/r+vFS1LdBid9dvhsv7MXsIo1I90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961143; c=relaxed/simple;
	bh=xU/CYcczb1t/SRGa70EwVJLymnEX/VSvsN35aX9fljI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oa2pD+hV7gtO3Nx2sQGacE1wy60e0ad+iWc6lCsBgAI89G4bFZjtY5UKTHOTLWRlib5LLeaJ6SyQl+u9gQjZK6VSvst0V8T9wMT9yFfCzLtMji7RtjCLAhBpcLn4HGVse5BNzTi6LBQfrFMMR+60Wb+uygSCZfQ0tcuetj5gFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4uW6cLh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4uW6cLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGwuEN8aOuWPdDIt2i3fXlP/T19sf+V0wzBi8VPQDDE=;
	b=f4uW6cLh/LeeHEFgbwuLmXQEi88/YWBW3Bj+JbSDpeE5Tge9wvJCcKDYXbya5wRkh44NDU
	Qti52vSXDm+rGTzRvYbuZ8mAIyjZPb915j2CGnYReYUfSxYZyak4UPPCKK/DTi3JndTuaH
	Nxl8cIOro3rjE6sHU0QEFcT8XEMK1EY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-M9-VNQlvOWak8vZnduys9g-1; Wed, 12 Nov 2025 10:25:38 -0500
X-MC-Unique: M9-VNQlvOWak8vZnduys9g-1
X-Mimecast-MFC-AGG-ID: M9-VNQlvOWak8vZnduys9g_1762961137
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4347bc50df4so112345ab.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961137; x=1763565937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGwuEN8aOuWPdDIt2i3fXlP/T19sf+V0wzBi8VPQDDE=;
        b=TBswHRP6w/AtMeIAvhFEpqMY1jeVN6USg2D5/KMijV8KG+pTNmRa+23dlun5Z9g1M0
         zmT9j//uQRnzxyKMJvCgIo7yFABH00n2IJQl3adXMHBbVEEuiLAuJN3nDgE0DtielvJu
         EAL7zEm4X39PDaeIiFOzJfegJ9ZMh5cJlcrAlS/m9lL+KWIdd+M5AdidxoCUQY5YfVZ7
         6OnY2o5N6V57lcqxBaHHO7ss/6mpHu5PLoj84nWFE6w2leU3JVc0aPLdW1iL4G2kAB4O
         RBinVIrkZug5tLUwm3ZnL8yUHvyvCsWo5jXfOeQB3e5hPNiu7fO/b8QhpEz904sRVhNa
         GrFA==
X-Gm-Message-State: AOJu0YwsyEQ1pDUHtx5NJQQxV3KE+j1wvR1euw1nq1yqSx3qQjyv5jvC
	rt1VXswB2AeDLgr1mAGxY40YagbPN2j+1j0sxmbrym4NHnNVut2hPfXPTidbzuJWZb7WEiYjVWd
	3opu1FCS8EB6zJLZSTQhhEuOdzK24PyWzRUyCbkD4YT/aXUaslTFqlsATM+0XPNiJNsbKhkCQuQ
	==
X-Gm-Gg: ASbGncv2I4EvkcTzbKO7djP2k2zilF9ChEi4OvH42FRJ3PGyG1cvVBckvhWNkcOKFfO
	/LzdXRyleT5fgS6f9yEmhn1xabXeKif47m+PCTqXUAqBDcmX9LOA7wVzemLzxuyzwp4IpMaVD/g
	XMePuRzwWmvNNoCuPwh0OyruiwsFTkrRtb66kvs8Niigg98o9ZpXfC1JDJyPOq/xZVA4tiRX72p
	4hQ8LJ9MLG8mKAxFWWZibD+/qt4sJCWfE4YVmZkAu0YLTk6dDfHc43805+VKfB8BwpqKgcvcXb7
	/Cqjby3FGjqD8nCJ4BJx67xqfnVTdC5+ImMNm5tvurvU88+VqKRF4yKYztNNlPPrJ4ultM1IFBs
	YxRhzb14ZLGG2OVV0OvPSCWP9MXZrxEA=
X-Received: by 2002:a05:6e02:19c8:b0:433:2400:2eef with SMTP id e9e14a558f8ab-43473998689mr49488995ab.13.1762961137291;
        Wed, 12 Nov 2025 07:25:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlHKxd08pHIvAbc/GL3gNPI3lt3l5Xq/NhiSJ+YC2xVebaLRoHTM/GawjW0Pux59gjueVbCQ==
X-Received: by 2002:a05:6e02:19c8:b0:433:2400:2eef with SMTP id e9e14a558f8ab-43473998689mr49488565ab.13.1762961136852;
        Wed, 12 Nov 2025 07:25:36 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:36 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/5] rtla/tests: Don't rely on matching ^1ALL
Date: Wed, 12 Nov 2025 09:25:25 -0600
Message-ID: <20251112152529.956778-2-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HWwINkbAn_Qotfploe8L5YA2Ab3N1G_7vuYts9mA5Ss_1762961137
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The timerlat "top stop at failed action" test was relying on "ALL" being
printed immediately after the "1" from the threshold action.  Besides being
fragile, this depends on stdbuf behavior, which is easy to miss when
recreating the test outside of the framework for debugging purposes.

Instead, use the expected/unexpected text mechanism from the
corresponding osnoise test.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index d1cc7106ae26..fd4935fd7b49 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -58,7 +58,7 @@ check "multiple actions" \
 check "hist stop at failed action" \
 	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
 check "top stop at failed action" \
-	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
+	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check "hist with continue" \
 	"timerlat hist -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-- 
2.48.1

