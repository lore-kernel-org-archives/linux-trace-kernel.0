Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647671A2567
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859653; cv=none; b=BRobLZP8x2T7U1mobMB7GJKZN5VpLY3iBp0t+YCBpwn3igvGM9zLLbnVUBkcfmcKuoK5BnzlU6XsThYJ0VdIotHVXyMrAJ5pNPqgQ7G4jvU2SfEL3cXr/kOLEPJ8BbHLWCkN9Aae7zOzEQ5V+KGgEFIVpIPmSIoTEXHFZizUdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859653; c=relaxed/simple;
	bh=HykGhePu5Waby/uF/gEeTut7MAeUH5w5U+QMGn9p0ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a22/lXVP+uqxW479oG/+9gdKWyVPIG0Xqu6ts7zzhVRU2s1yYuLLXzRW3ilgSyt0/b/GolqoAikyOlQOLrYLFmntIMHk6Z8BUvqJrlUCZnnxzU8gDN2hbThsZPLcX4+25nWxmnFBwvu9ojYqpYavt9hxD/+ko7Tt+LbqTGDQ0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfGviRa1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfGviRa1"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42817980766so63242715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724859650; x=1725464450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RM2/YRNqaAKVm5MVIrmJ/pD1AXRYechixdNATzKjho=;
        b=nfGviRa1/x2YHLm/uM0isfWhDIxiyl7xYtnVvqVGt1puOCe9marvxnvxeHemOBTBwy
         bBhFVQLWcZaXV8tJa1wdWYbwO+leIdQ/UjL7AveAt3SiwcThur+DPSHEQMM7//Us8gA0
         MdMQR6yzJJjIce1wJaFi83czloVgRaP0N9cCKkIkm8hHUYeXv3gQL1gP9mUiky0CbhFw
         G31oQaZSkoyOHUwAn+eaZ0MuEigDtVWhFu7bQYzJUx7qIi53GbhdzzWApFpmerTpMbHU
         h+LDpi/VABgAlfw5UuCvF5XaxyUceP7j+jAbTOeEhBxOmiP+EZX9RknLYu9OPKx04Aeq
         B8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859650; x=1725464450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RM2/YRNqaAKVm5MVIrmJ/pD1AXRYechixdNATzKjho=;
        b=h1yLTEvsY49h6HzquWZpUJKGdHNTzwH2GGXGLaA+at416cdhLL1r5jb19KcriCBFog
         iOErciFxra01zoJc/kKPV6QNnzvEMx1jJ/VZ/fhxmaFqqZrRy+0HKLy5lXaaVpdIZmhX
         baSAe8YHD4QLaLPC+ugkqeIxTEx5rf8avmZ1ICGdeDrC0AHbK+tzLycFoDVzKUiVJ6K5
         IdvL+OqGMiK7m6yjL82F3IMvrTFItndsh17hYRGMQDwumcxLWP/vTePqvhA6D848S9SK
         puSnArAxxM5E68JBf7LCvmkLZINwWNDTZeANVy5MpXnLxaBmT+MNAOenmZgHGJzOdNG9
         j05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzSW4bQVuwsA78+uqvaWmFA6Nr99u0pg+GDHHtSvheQScSxlwVv9ENzUAp+KWSm6d0ljLoKhYrGpYakL7A0BQQXZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzel0wRGTTMFV9vN/3gPe0KxbumdsQilqz/rDIRmJcW8iyvhTDj
	EDXcWQ+kznyLCIVB1hT3lE7lIw6zB7LMlgqxxAPbDs+5BbdB5M/mh5aBBC679IxkD1n5oMua7b/
	nRw4vhczYpdhGW4DJeQ==
X-Google-Smtp-Source: AGHT+IGJjmP01VW6ffyzn6YF3275GVaOcQu67Zs0O0+IsNi517+lhBzC6eWFquc/CuzjtQVxikHAUoj4S+crJs2T
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:2d08:b0:428:1d50:b9b1 with
 SMTP id 5b1f17b1804b1-42bb023d043mr1825e9.2.1724859649791; Wed, 28 Aug 2024
 08:40:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:40:40 +0100
In-Reply-To: <20240828154040.2803428-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821115636.3546f684@gandalf.local.home> <20240828154040.2803428-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828154040.2803428-2-vdonnefort@google.com>
Subject: [PATCH 2/2] ring-buffer/selftest: Handle meta-page bigger than the system
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

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
2.46.0.295.g3b9ea8a38a-goog

