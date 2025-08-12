Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380092F90CE;
	Tue, 12 Aug 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016077; cv=none; b=fA20xB866AeFjsOi0eViHX1/FV2nLCa+8bnoER0efbX0Vbs2JvFbT1ggzbzrUpvHhMG081q0bnVhfHFLmERY5idi9EHpESO+GFoCWwpWPnLCIN3GmrZLMsALuqF0gehPsCsALKd2puVFjgEScQiehB9VNsN8UmTamS1SA7lQimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016077; c=relaxed/simple;
	bh=sH8ZhJxjPjK/W5fojUbfcWKAEcP9xOolfJwD3H7oH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAU3Ey39dEFbKSXNPCM1QIjPf9qdClvjPcIZRD0qql0mM19b2BTREYigMDg0fjKfnpzcGWTB+y4owIMUlIHy6ki4OrNlte7pmNEuQoghvWoZddD1RtgMyYyi1OoidS/6OYj86tuT9FlOkj8jLtJ4J4VBwD10eaRNUOT+e7o20vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XneTJzWN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XneTJzWN"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e2c1dc6567so369003385a.1;
        Tue, 12 Aug 2025 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016075; x=1755620875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM8pT9HqxyMa3H416EZmlZYSb6JbMTeAfDZVPtYuWGY=;
        b=XneTJzWNo8HXowd+RaQWjEar51JsfU1BU4oJT7PG/FIJvipqcAyMXUX1Oa6Q0qOlb/
         0MtbF3V4NwaFKK1TmC8m5K6f6e5/SIN2I7KcZmevfkqsqDS6VwUK6Gk+HkV/CKqekxyt
         eUBEhofS8VGaYYq5W/oOz2MAHTPM53JvSX5HLEVjKT+TgVuQUjGqhVU7bPaxNa+M8hd1
         sxrvd7wtkhZYKFHawJss59ZXmEVEi2gKQlIKJpaEhxJ+ycxGPdaqcqJoCfCeU61nUC/l
         7PyUNuE15jrtHQUPxRNNqvEh0XLTqvmD2WUmBO+5Lhay32/hZrIHJhj3oYce/kPpAYvM
         hbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016075; x=1755620875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM8pT9HqxyMa3H416EZmlZYSb6JbMTeAfDZVPtYuWGY=;
        b=WQPNBlHdfmMvUlVjWJWxUAkNBS/IX6C6A258QWrdR0PTexJ5zFKj9DpkvvlwPOn6EK
         CrkQZJQgFIhp6QnhKiBhG2Eu332nG753B07Hw9k9vIGGshUHhJKo0Mb6UqwwS4qG9LES
         YhoRGZz9wzXScgd4XD8LAH42fXvGPCHkM59+uGcDuXce4GBaPDC8sl74+RkEYKStVNts
         3hU1FzEcLbwDA3UHZIz94GWz2d8Ax+SGbXhHI3NKRpnpqzl9VlJXyYH56vjWTR60iyeB
         rYh64CzecZbhLaqF3SlPvvERYM6zXZaqa978G7tZf1u6J5owWG4qOR0vJyGnFt8zZabu
         1EyA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVLGIkkmTi4sexIdoEQf0zfbxmtiv3L9CRbAUOmtv9PTXagYFY/UZSdEP6VLfXbgLhZiZRPwhbjsE6O+708eGcC/h@vger.kernel.org, AJvYcCWTmjInpAwjKdE7XEFkjcIGb6+qLg1Zku3b2OchchcjAZtj45n5FwwvqJUBh2mAHu/LckkC+YZshmjVwbtS@vger.kernel.org, AJvYcCX+uT6G2mpXxgBHxQEA3BX+P4BRyG76pKktD39EQCnNJAm0rcaRiFf0PWUHXo49TuidMmPh8B7RIWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SWrwxBwxVucaUx9BhwEolaBbgIhr0gph4nis3ynqKOOoAWM/
	dnREFtPseUwsPR3GSu9WRyR/1BmP8VQSwUBx5KV8DKjAuAfqRNAT7UJztTEXZlHm
X-Gm-Gg: ASbGnctDBFeQCc8p00atEsUZEV1CoIOZFBEITnt3RC2HThpuZ1pHkZUUG1ipmE8wfFs
	0SLjHPiRebDu2nhs03aAtzr+n/ueHEAE5TJ/h+BOKfA6ELIN8HEDblyB5q4UXNppFQv6yv0xWht
	1YmcGctQMdNU3P//uxhN0MOc8PMbBLRab73V8ifvwvvjD3JW42win+O2SVt0FxODjPSv+cFYHRc
	1KgWtMCqtpeA0z/PlYLWiBknMfBnpJXnfjtMJGJ6Tdey3GOYDZzH7kHd6hrRXAUw5mIg4QCs6s7
	ytBMlZUcveAOb4rMLZuxNRSfL7BCxjtbkQrOARD3YkbDse+U6nlGZt9hhiNWe4Zh4e6TN3Y27WZ
	kVrNGkQBCu2tGXfJJMxiFvazeW/qPZWHZDgSq4BZW8EamH+ecSbIEt192hwJZLRZijpvr/F9Bzy
	ys7Euftffj4wcZ
X-Google-Smtp-Source: AGHT+IEXWLCDOoIUg8sO/RUBFwfq47KnsYs2PT1+RjuQgmzwjpMo4+nK8+M7EzM4TrdX+OU0o6rqLQ==
X-Received: by 2002:a05:620a:a811:b0:7e6:30dd:529 with SMTP id af79cd13be357-7e86446841bmr54878485a.10.1755016074924;
        Tue, 12 Aug 2025 09:27:54 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8079cfcc9sm1269013885a.29.2025.08.12.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:27:54 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH 1/3] rtla: fix buffer overflow in actions_parse
Date: Tue, 12 Aug 2025 12:27:30 -0400
Message-ID: <ac995f5bd29d21254f76c636f779e93a0247273d.1755014784.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755014784.git.ipravdin.official@gmail.com>
References: <cover.1755014784.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:

    *** buffer overflow detected ***: terminated
    timeout: the monitored command dumped core

The result of running `sudo make check` is

    tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
      Failed tests:  3, 13-22
    Files=3, Tests=34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.63 cusr
    27.96 csys = 55.67 CPU)
    Result: FAIL

Fix buffer overflow in actions_parse to avoid this error. After this
change, the tests results are

    tests/hwnoise.t ... ok
    tests/osnoise.t ... ok
    tests/timerlat.t .. ok
    All tests successful.
    Files=3, Tests=34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.10 cusr
    44.38 csys = 85.55 CPU)
    Result: PASS

Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..eab51c0c0ce2 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -131,7 +131,7 @@ actions_parse(struct actions *self, const char *trigger)
 {
 	enum action_type type = ACTION_NONE;
 	char *token;
-	char trigger_c[strlen(trigger)];
+	char trigger_c[strlen(trigger) + 1];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
-- 
2.48.1

