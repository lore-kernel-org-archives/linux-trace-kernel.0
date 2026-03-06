Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587373CC9E9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807787; cv=none; b=gXqDBPRHCLbw14lWHye8U001/R6RewGry6x6uE45n+RZ7asjUHYYz0FspooNEcTWHg9hyiBZHafojtZiWa5aiZrbtfb2hl1vwa3S/tXQGMAeA8zi6YwDzCUOGxDw9sc8DB1zLoVTf89eeuSi6UZ8KZmUvNrrF2NoyQbuMcY11to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807787; c=relaxed/simple;
	bh=ea93niBYI+Rj/6YycglV0K0bDZBQ2z3tLiTBTzWOxio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OoJYqC66QDPBIVcpvrCXVXYqyrwXu2Yw/gx1cTzNgzhc//qpbjwFW2/eWSbumC8S0rE/ZIng/qveQoNzGv6DbyX9zIBps8QV++CfOq/cf+OhXO6TlRWVQeQuI035l6Lgk3EfjIjlxqM2zweElKBR6oOOA1GYSYAST5aRdYtQkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbKRlYhx; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbKRlYhx"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b937367d30eso757306266b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807785; x=1773412585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAzsYfyBwss8qjbiN9KhoiGNV9RHrAQ+UoLBq6ZtFBA=;
        b=wbKRlYhxNmD6h6zRFQPFqKNA0SGXQ+ZdEwXkVaHxImZDNM6nfM9/tZ+0iIonSRFSrj
         r9P5UoCeyfwvzpssueE80dVjSuOJn8eDxdXHZUPMmgVlAL61cAP1oScwCVSRfi9hOkU5
         CEjvmSlOoYGTIJmFF5nmvW9IKfejUTleUs8JdticbgIN7tDBMQVhNMfjeAWrDNv7Marh
         J/99+6vreI6kkGwHgBDyJGQ4OxmLj4dQ5eL8L+O+gAT9YWDTZusjZRhce03T5AUhOdD0
         yx1agpl/DYx7ECrmyRwhwAl1UeHum5DSLoVtiR4Ts6o8H7EPUBudFEV9UdzpjNpFhk9p
         UI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807785; x=1773412585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAzsYfyBwss8qjbiN9KhoiGNV9RHrAQ+UoLBq6ZtFBA=;
        b=q8FC/8HJ8Guk0yigcwRAtEieIRQU5cw1gbVZUzy2dCnReahKQR5QmjAUnvBkbDBLRs
         ZH0A1rTN81oUIhJhG1Lnhr+G0/oo3gaSxo/xnd2Hrca39phrC7NsH1DxDoDqGrmLt2tC
         gRDGmSFTbNKOs9IBxba7Y8OlOcKEXHdYr4Bs7MFRBcMJ+FloYbjmDlP5mSs2kF72JMdO
         sE9T8h45SMTidoRst3/Ni4800wnHa8js6f2qSsuOT6Zu1sgUSO0kT1/wax67wulChD+U
         pcEQ4nRiKulNgVb0+ZT5A9DoeHTtIFq8Hf47n7v4Z0Gq0fAvhCecAZqQOxrBrXasWsVN
         vaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUKM07GRZIh5SRMDwhpGcGsGmeQIzRumfRXl5V9/xEYNXZIxjJ41tMFG9UP6GuGodbGXyCqTG3Al6ga4jKsGjj+Duc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbNyrD13tGJml0LDtZZ6jPJS/1XekBZQaZnoQmeBKAy7pnMr0
	KUuCG0s9eT6mAphI4grF75NcqfwuIyaB6fHRWVNp4iUrOY+q03Vo6yctzmcw9/wNUW1PQbTTpJA
	J11clb16P7Kq2hmDHsrpa+Q==
X-Received: from edge19-n1.prod.google.com ([2002:a05:6402:a553:10b0:65a:1fe2:dacc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:944b:b0:b93:56a4:d6b8 with SMTP id a640c23a62f3a-b942e15531cmr137153666b.50.1772807784377;
 Fri, 06 Mar 2026 06:36:24 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:35 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-32-vdonnefort@google.com>
Subject: [PATCH v13 31/32] fixup! tracing: Add a trace remote module for testing
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"


diff --git a/kernel/trace/remote_test.c b/kernel/trace/remote_test.c
index e5023b9d2611..791128d7fd00 100644
--- a/kernel/trace/remote_test.c
+++ b/kernel/trace/remote_test.c
@@ -28,7 +28,7 @@ static int remote_test_load_simple_rb(int cpu, struct ring_buffer_desc *rb_desc)
 	struct simple_buffer_page *bpages;
 	int ret = -ENOMEM;
 
-	cpu_buffer = kmalloc(sizeof(*cpu_buffer), GFP_KERNEL);
+	cpu_buffer = kzalloc_obj(*cpu_buffer);
 	if (!cpu_buffer)
 		return ret;
 
-- 
2.53.0.473.g4a7958ca14-goog

