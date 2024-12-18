Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456391DED77
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541422; cv=none; b=V6uPZDZSMPlksL1GpKNo0DC9xYRonNq4cTMDt54y2ZIlEdvmO9bQ+Sa+WjlojJsedIBTmTrJOxLbrfdbSCoo6/x9dDgN8A6W2V+u6vHHBlx8dS/ncOOecpjmkjdW9FYG8/wRQEWO9PKkaPl94XB+nkfwngC/k48qxj6ozb3tp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541422; c=relaxed/simple;
	bh=iO9isvWf752YGak7VS4cPUz+0yRT5dyL5xaBhozN1yQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hMaaNX2Jka2DIRzcPrwZHsyVR70v6iHwyWsHaHxNe7mwRe9iemFl2vcgil3mtxZ3Xk9GMu4bADMOJfWFqA+UhMfJ/QBGLvl9PxCMOiDZHsv1YMyVoNAS4gLpLGfhihAtbPTcWm16Y4qDGet1Asd0JdB7CMjNWRIvJT6yV0HHhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuCKBR/o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuCKBR/o"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so30228065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734541420; x=1735146220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VfjgK2SOmknIlUUHDKQAA0R+8BaX7+ocU830dMMDKHw=;
        b=FuCKBR/oHhyYJAj5ovZdtiu7G+6Oz2i0J7T6dPawgJsj1V3OB6OYBvXSK3Z2SaV/MD
         3ZZKWcZkf+tAvMW7IuLwQxZUYqL05ipxvP90o8RVdFIi+0w4yu2wi5CFCN13S3Ik2yIK
         WkPIDRwLmRY0UuZHoivghcWEEZPiv5DjRRB1eUAcG3rA5b0/25he5WKSjiRrpwGtnW30
         l58yUO7neGxy9nLR1t+YWj9DwViVufdnaC1O/ErxaQkDYv8PtSNJf9LJbeIuNlcw8Qfm
         Os73a5Y+3dYpKMFnx760JcYYEQUNvd3UIUf8lYwYHArNthf00naMHZRAeEHCIK/lsBH+
         +6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541420; x=1735146220;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfjgK2SOmknIlUUHDKQAA0R+8BaX7+ocU830dMMDKHw=;
        b=dnNznGb24USUNEB6XQrk7A6plPYc6ii/r7vg2jZiJLr8FbdsSQ7KIS+X46tV6ILA/s
         uIBCgH+qj6dY5C/IaTzWhbJC715vTge8I+P8RJDBN3wrfkiU87LZZNt3fSmb967RY6S1
         ZOW60b2ESsAXGZA0BpkxaQ2pS+blwhM88gAsRNMWjmn/VCvFJw+oYsUpKQfVTmBDcMVP
         i4ubq6ttAAdPsEstbFqRopJnAiLB+HTe/v2xQLpRGodoFFfyjNzVBtFcwXjihBR4FQKf
         r8CMPRxeRG9kiOhzk8/4Q+DNpIbXdmXT00N10Be+2SiluVYyZUOc7fqcOLy3ADDMlSiD
         IWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUTqLAUCfylfGxlIc0+rPCKRDYGDA0fhE3BuCJ4oZzs4tnI5LI3T77uWKvakDOpKHXgclX+gsTm0kCFkaTeUcRR+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfkgnl4ISxrb4XzBi87g11uViuyCbCTaUQ9gJGnueHr7724Jr
	+kSPOf/n34H7vEMpyiAWH8CboJdptRykRjVgKEWy35wqtOHXvyD02zrjcasTe9kYr9+Ts54G8Y0
	+GBYHPj38Ebblx34FfQ==
X-Google-Smtp-Source: AGHT+IHam9G7o+Bp47zHT8wI+vFS0i5PkVHHYzHjKDxZPXVx54N8saOP/ifSLAMey8jYcZc34wHD0NmTuZLSmZEr
X-Received: from wmqc10.prod.google.com ([2002:a05:600c:a4a:b0:434:f0d4:cbaf])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3596:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-4365535f498mr32760275e9.8.1734541419771;
 Wed, 18 Dec 2024 09:03:39 -0800 (PST)
Date: Wed, 18 Dec 2024 17:03:18 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218170318.2814991-1-vdonnefort@google.com>
Subject: [PATCH] selftests/ring-buffer: Add test for out-of-bound pgoff mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	aha310510@gmail.com, eadavis@qq.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the ring-buffer mapping test coverage by checking an out-of-bound
pgoff which has proven to be problematic in the past.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index d10a847130fb..a58f520f2f41 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -233,12 +233,18 @@ TEST_F(map, data_mmap)
 	ASSERT_NE(data, MAP_FAILED);
 	munmap(data, data_len);
 
-	/* Overflow the available subbufs by 1 */
+	/* Offset within ring-buffer bounds, mapping size overflow */
 	meta_len += desc->meta->subbuf_size * 2;
 	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
 		    desc->cpu_fd, meta_len);
 	ASSERT_EQ(data, MAP_FAILED);
 
+	/* Offset outside ring-buffer bounds */
+	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, data_len + (desc->meta->subbuf_size * 2));
+	ASSERT_EQ(data, MAP_FAILED);
+
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
 		data_len = desc->meta->meta_page_size;

base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69
-- 
2.47.1.613.gc27f4b7a9f-goog

