Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BD71990D7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979414; cv=none; b=oeut4TDit4xhGj/3OWKktW66z4IElCXCxp0DfbkpnO5T5kMno3Sqk+Weg6QIt+vGvarCmEce/sfi5UM/KOhNgP67iQTLkn8rzszYgSwDKthrkGIrl9sVZ38tTBaGKHrMd3/6wraEIa6YGvaMAW5h2rxi4r/+XwKz0/nhBWoKxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979414; c=relaxed/simple;
	bh=StcSVY/lDu3pDPn7KCzbIdoI7ZQbK893oOzW+eD4J1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jyjmviYEoHrz7Qq+HdVmnPnefrttwhcGkQi+dAaCO7vN4An0EzOVC1LP1mxMoeoCCauRymk+lWbXj3aJzdB37NmHoZS9r0/APemwKd9dN8Y5AtFKow3ll9+oNhZ73/CIwyJepVGiS9QCdcDtDz9efQi8LEM5iIAYl/FW8HGsoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTm08t8v; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTm08t8v"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-374ba33b2d2so337480f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979411; x=1726584211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3UvfZk8XE+USBISXOF2Fm+pc+slRVmygcZXF9i0/w8=;
        b=jTm08t8vUbYCshO/hKPjKiULjHJgBJmDzrsYJif78iH9/e7N+vWr/xo/dZYFemrlqY
         CvEnpVWU1C2CpkoESYLybyC0MXdvf13rUfMsPw3xdrBW2CG+JyTDhvEUuLMEIGuleGFv
         UElnEXjoWCzIQ49qiarrX9oYzb2JQY93LCemEJ8bd6yKhmjCPi3sBAOf2JhcGhIFEI1F
         xBveuOkKjzut8Wz4QF9uEOrFacqE4CJxdl5RJuhUOYQx5PqqIQtHqsTtVmwkf6astlxt
         vGTeMNuap+vAbwlBrRvQaDG4l+kc7KRVSU94x0BRlWt2cJbnOOHg2fRntvxGIrr6nK4u
         lQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979411; x=1726584211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3UvfZk8XE+USBISXOF2Fm+pc+slRVmygcZXF9i0/w8=;
        b=qhM2ook2i42jQfQJ+7dy5KfNiogec5kfQQaICdMG4BTy54dPS6K8SqGg99Wf0KqgjD
         Uz365H6sSifDTaECLErV4m51j+le10poA31KMvU2UfTGe9Ea4t4uHOQKVXUnFG1IJ2yj
         tpzeMflfcMEpUOFTwvBfGHaceOm7jNgcSBMy/8dz7ohjKcZgjqfdZSsSqBpn56lx5QTk
         9CvwFcCj9Kz8ZafTufMpUEOwGpyTo5P0dM5kI+kcTUO01cLRu/PPZRNpQA4fOnuGqgjW
         vX+x12XCFTJ8V7aGUaFgb3qTDD+ydCMVd5tNf39r+crAzwA+oIlgJrgpVnsci5BBZFr2
         sC6g==
X-Forwarded-Encrypted: i=1; AJvYcCWT2F8ibQCJvbiG4JN/5xo1sBnF+DHTJc9AMfrpgt71KPSeCAE4/tk6zMlliYGDnv2LtPacI0dYR+ic3dz4caVRKjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rIcEPtBjAD9uk5K8Yrut5/agSjlGwGmGGzfxuZQj/yVXxOxA
	IVKfkLRVisqj7CNH4bac0ZSItjyAh2jCQLCyem74CeAvF96ouRBAQ+ZaM0NK0YOa7Yj7zCXSZj+
	UaNi9hU7KoS6+g700IA==
X-Google-Smtp-Source: AGHT+IHetbW9qu31X58DYWM84I1oxzGTacN7+kNuoDfPaicFp0DuUvOgsLQpABkvoagcZeq5XN1nlAQ1dSCmxOfz
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:eb92:0:b0:371:8d08:6302 with SMTP
 id ffacd0b85a97d-378895c333amr16088f8f.2.1725979410808; Tue, 10 Sep 2024
 07:43:30 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:43:22 +0100
In-Reply-To: <20240910144323.2888480-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910144323.2888480-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910144323.2888480-2-vdonnefort@google.com>
Subject: [PATCH 1/2] ring-buffer/selftest: Verify the entire meta-page padding
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve the ring-buffer meta-page test coverage by checking for the
entire padding region to be 0 instead of just looking at the first 4
bytes.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index 4bb0192e43f3..ba12fd31de87 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -231,15 +231,15 @@ TEST_F(map, data_mmap)
 
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
-		void *addr;
-
 		data_len = desc->meta->meta_page_size;
 		data = mmap(NULL, data_len,
 			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 		ASSERT_NE(data, MAP_FAILED);
 
-		addr = (void *)((unsigned long)data + getpagesize());
-		ASSERT_EQ(*((int *)addr), 0);
+		for (int i = desc->meta->meta_struct_len;
+		     i < desc->meta->meta_page_size; i += sizeof(int))
+			ASSERT_EQ(*(int *)(data + i), 0);
+
 		munmap(data, data_len);
 	}
 }
-- 
2.46.0.598.g6f2099f65c-goog

