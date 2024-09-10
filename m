Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942C1A0B07
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985426; cv=none; b=gq1Li+XW/3TofE6AuSnNw0ZHyGJ7CnXCByuVy0H74Y/q+JA1N9dR8jS3eeTfcJReUWQVwsAXp45TIXQZPbA+Waur/uJ5L/Z8SlYo662TtzP84JigMY5Mg4FGDBtcNr4FCsVzwXeCyE+xAxuVHeixrZlXUsYJHS0fEIIyvgFwNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985426; c=relaxed/simple;
	bh=IDxzP8NIFFLJrT3njglStxjT1iS4xr2kKaPxUTaw2eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxY6YdK7JmlrXWRGPbDwzAzCRtQA5BXvVaAA5vVWLN6lrzdUEDPV3uKyIaPJOsklGEGDEFUS95yaMbQXTpLa00VX7CHfZst8pAN7O1nk1DAq9d56Uti28X264I4MrvCYCp02Q4fk48ZFINAia+7ajweSVdWxZVakJXOSGteWnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF04tJ0U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF04tJ0U"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a672dso178803267b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985424; x=1726590224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3gEWXD/IZ+HnaT6C3cDeHppcfA/fBRmYbhkS6oYyo8=;
        b=xF04tJ0U4KKfInAsQ2RTTKV19JHTtz/h/Ad93cLe89MZ3K6qUDQWFN2V4xAKPgblGp
         V5mv+JXD0dvp5CINnv+l9SZwq18cbj3CUY+rO6ob+x2M592R4hnj4TLFf4KUltqkuSmk
         1tlXmhF6JRgHV7VjrLqpHQ2SvA2EjGDSwFY2VQmT2jRVc8HbJcQs2vWa2+oLkivX7+Et
         zKRzSVW7q6QqNpXLooUOW+9NPpWwYAspk5NXN50gzF9FE7+UoNVEKq7wYn4ZW0ol1Ryr
         JnhM3Ya9MxSqsIHnGqPcr7qN3HlTjZsmX+5gk2+UAiozgjClNCqJyaPfviMyXO/VLhdZ
         Vypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985424; x=1726590224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3gEWXD/IZ+HnaT6C3cDeHppcfA/fBRmYbhkS6oYyo8=;
        b=Ig8vEmh/QrdlbuFeNcNw/y4GQn3AJ5itmynCe5v4h81dc3YLFE1RJdvUKOSjbcHrbi
         KpkdJLCimTWcfWjDmufsVyQf07siWD6VkaMLcdDu6tWRuQFpdQh7IJM6E1C7bCEDw5oM
         Tl8hd4bZQcRNgqvcdiRr34FvbQ/MzkqHD/Oteba56kZNrQ+faBNIytMzznID0y+evo2u
         auXoAxoGEmUeHM06l+ZMFLDqf8jKMM5p+ZIyb/SX6RbNK6PyrMjNuaSgiv7gnO7dh/W4
         MHE9gECh8SvB/6xvylTN5c17So9pW1MX/7lX4KKznZrvMuY9W7YFAnggjMB1blT1l2o0
         bzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDbumNcIl5TF6ODtUDKWJP9E80q00HFbDedCmyyz0Mh+/5lI2DVvE6Qox+aonBliWwBU8RnaTbEIvDYlyDMyKkBf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTFHq+yhkHZIujz6WzWpHfE322EHx58QJ7+k2w1XLI01coPPG
	2zsfzF/9mttXretxZhyhm7NTRxgfA68jb8mfWDO2hUtsuORJDYqd/QZdO5sJ95ClwQaGrAgwoxt
	RDeFWLhihELcZ/Ik7OA==
X-Google-Smtp-Source: AGHT+IFIKA+XvPoOxw+v8DGyTZTQiSOBgMRqezK95cE9yrJOsqwf2B357BaQ0JA4EDgrcvgiuQT7VwrhPTbXI7AW
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:448a:b0:6db:34db:bc80 with
 SMTP id 00721157ae682-6db45163fc5mr3107447b3.5.1725985424256; Tue, 10 Sep
 2024 09:23:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:35 +0100
In-Reply-To: <20240910162335.2993310-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910162335.2993310-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-3-vdonnefort@google.com>
Subject: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger than
 the system
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index ba12fd31de87..d10a847130fb 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
 	if (desc->cpu_fd < 0)
 		return -ENODEV;
 
+again:
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 	if (map == MAP_FAILED)
 		return -errno;
 
 	desc->meta = (struct trace_buffer_meta *)map;
 
+	/* the meta-page is bigger than the original mapping */
+	if (page_size < desc->meta->meta_struct_len) {
+		int meta_page_size = desc->meta->meta_page_size;
+
+		munmap(desc->meta, page_size);
+		page_size = meta_page_size;
+		goto again;
+	}
+
 	return 0;
 }
 
-- 
2.46.0.598.g6f2099f65c-goog

