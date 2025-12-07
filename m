Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1402220F3A
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Dec 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765117672; cv=none; b=t2d0AauVsazYYJZBpD38PD7t+dKNLfLBTggmenB7aPc/N0PR5d+Y6/125z9I78aHkLU05mWAyQg18LW2XuuNnfP6dT+HNMXcqByIm7KhSgtT9HIWHTi+KbtyK4KG9KXTtUDf+ynWRlp9VRQewzV+vG8gLTswMIf4UW4IkiS9N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765117672; c=relaxed/simple;
	bh=5sL1cro8KEGG9RlTROb5DMFcJB0PYj+A495Hx6VrFIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9GZqmrb6BVTY+h9mAKSriHelZ2T8k0mcXxbzzdUOq8FB//XS6VgyIos9T5QO+UVT7xwMDAhOkTjNw9p8rgHwyFBBsS2evbYjanaUEngTOwmSuYLBsivQ+vnugy2f46BgVnruAOkFjVvxUbVs0qLmibcad2NxpBjc8bmRlVPUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi9BLnhS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi9BLnhS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso4089588b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765117668; x=1765722468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZoqFzyLg2kbG3TtAml5Ndu6SDECfKXfTe0mjyBhZ8s=;
        b=hi9BLnhSQ6DdCue6jzOK0B9V/IzgJ0LoVVWJPPe1D6dcn0i6l/bHna+hCq4X4u1D4Q
         8y09pBKzeNlM8O7jEEwxoxgEqYE/uLBJDJ3cQ6kW2SKpUqKQNnDm2+Rf2ZGarAXfYYm/
         6pL5JzbIrYU4TN/KI1E9pRkyIbJZ21q4dEzZTdyz5acErTKbNaMqy5q3xdY3ld5t9OwJ
         QEV666QsgczrFBJxtgOD1VOZH8fsL4lQua92jvt/C0PenWXyCqv58oyIgJ2av07gwPuB
         rq2dQATIGLbELBq3om6sEd5y9Vwnnz5jCHjXYBTA9LzF6ynKT8jADxh+ROc+gv1S3WzS
         a+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765117668; x=1765722468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZoqFzyLg2kbG3TtAml5Ndu6SDECfKXfTe0mjyBhZ8s=;
        b=igIIJ1yevjF3/WfgEtm6tWcWkLXWRKBzI2CZYJvNrlXK72pCfwett96Jtc1OGQWKvx
         XEKet9ewS3D2xX7HLxaVl77LVPr34+SHxP1dhM/rNUvh9Fu2AiOyTJ4hMMZ7rBNIL4En
         gBB8UdR77Klhq829y4O7HMyFFyUJ13MP+/I44wHqXXzSeVTEkOEvQCnlt9ImlckvymUK
         HU558b9aEl852viSSAjaMLyD/CsKCSQkyr6CA1vEq3rkyfJ7beJUEWM4ziuGVbSDP1we
         XJYGiSu2RUjjlu2Rbkm0weS/gYZaOmNcoexyA6K4TVqqm8S7eVQjPGHbirIZ227kcjK3
         i5iA==
X-Gm-Message-State: AOJu0YxLVb/n/Z4FPd8FnMYnY5uNF84DhVCD0eFL0RR4v7G1kEi4Q2ST
	3/IjUS9DFZp9EXbpewRLtVWOxKlN8NIsWeFYsaDKfJOe/b1r0VQ/t4JP
X-Gm-Gg: ASbGncvUdhXjx1nzbFa+ksLr2uSCr5a9pPgpSJTWUyV64ad+wbwQPVGI2RUGIo/aXHV
	+vbc/21HUbVGZf6p70NTxiPXnbzcBV472bVMT8u42hEcNaIcPYAN3/5CAc/2v1mCU5eMveHfblK
	qrY5XeBNP3WOMdyd7yJgWhFp18gNan7J3s3MmczaBPKadB2k3tFId5AEygF6MKY/LGziVD0066d
	h7/AJ10iJscPr0IAcJkLR8yvwPxekOyPmU/76Y58LaEtWFrlZGMBnCQ2Oc92MBNrSB8/NUW3awN
	pqsYDfauFU0zk5Ytd6FmsvV8u9+VLCUKHPCsMWrVkGVbCSoOjH2INc2okQPs6DrcVpls7iSGHr7
	Cap/92BpngqoMqr28t+fj/UOLDDARJvk6OLIVDt7mE18PE5n8pltm45qGB5YtbVxZRqYOsqJZfc
	x4tPT7ZxNoAWfVm//OewnJ18WFSaU=
X-Google-Smtp-Source: AGHT+IGfnG4jYvcEi3Gdc5YK0KIALBXdc824v1o9JQSosCvDEGj2/jglIRKQQx23RvIL/yrIWKCF0w==
X-Received: by 2002:a05:6a20:2444:b0:366:14ac:e20a with SMTP id adf61e73a8af0-3661814b3b5mr4964878637.72.1765117668034;
        Sun, 07 Dec 2025 06:27:48 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686c32deesm9514792a12.13.2025.12.07.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 06:27:46 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v1 0/2] Use BTF to trim return values
Date: Sun,  7 Dec 2025 22:27:40 +0800
Message-Id: <20251207142742.229924-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The current funcgraph-retval implementation has two limitations:

1. It prints a return value even when the traced function returns void.
2. When the return type is narrower than a register, the printed value may
   be incorrect because high bits can contain undefined data.

Both issues are addressed by using BTF to obtain the precise return type
of each traced function:

- Return values are now printed only for functions whose return type is
  not void.
- The value is truncated to the actual width of the return type, ensuring
  correct representation.

These changes make the funcgraph-retval output more accurate and remove
noise from void functions.

pengdonglin (2):
  fgraph: use BTF to trim and filter return values
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       | 74 +++++++++++++++-------------
 kernel/trace/trace_functions_graph.c | 64 ++++++++++++++++++++----
 2 files changed, 94 insertions(+), 44 deletions(-)

-- 
2.34.1

