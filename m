Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479D2FFFAB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834421; cv=none; b=NsKgL8pd6X5s83I5H7iWtdcN165M3W+lJw7m2W35l/6ftQF5Hx/GmjbbShmu2siMj1no58rlLy+GbEIyWD40SQffRtAU8YMWFNsTUcpqjq5Rg/mVIJJ9jhOHEf16kjcmR1alBqF7gZ6aEvjm3HhHhkyC6+OBmedQb2fN1+7bcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834421; c=relaxed/simple;
	bh=80SRJuOgcTTOlotUZtwxNq10fJ7vLgfVquViWgwDO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9zYylL+rTEpX55RczgFcTE8ZGCt/bPqf/V0m36FMdNwoKKe3HjqA6SvSxp5up0UE8OI+wx4QX7/i09HVeuAcnrjiMbk07khhIrRiWYO8icnQrSgtOHKsCFSxHpsIMz7ddzXEdu0yb7/HL36HzOS7sawBm45LRTNgUSiH2195Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYGpd9Gi; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYGpd9Gi"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-641e4744e59so550008d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834418; x=1765439218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=VYGpd9Gi9+XUN1o1QF1ftGMaiBlY7c8AWMnkdyCUt+KEXYy/h+27pTSr5l/VBQ9P9K
         BL4LQP2mxLgWUNAAtxZj2ad+cVfRCXs5aYOhBuoVcd9wIFPzJvt4DoikNjyFDjKwqq/u
         TBTtJKolDpVgyWgTXONv2CUme93uYgj1MArdB4nUAtwWG6vCyGgIEidQ+9wBRveKHxEd
         lTSjmX9vHn/zWdkCqUsZxyimK+6i1PIz9Xv3Sf0q8x58XPd13++e0gYtX1jZjGsKdGcN
         sPTGyK0QfroDBZhZm4gSG6BHL0h1wrpTTQKHuEKCAmNu13Osne2oplw1cXSA0fzIfDbI
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834418; x=1765439218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=MV91Ne9Jjy/gkVgviLHNbFqQrT5IKHGxNkN1o6WBRbTf37MbWIFrsQz9hDKwQjVcK5
         mwtzI4YGG7gGgVDP8aakohmPg4YmxNWWocBsk0LQbXrpsvkNOcpr8qxmxnNzotfWMfcm
         FMxdy1110d3Kn9wGmngWjhBfSRsZR3gUnu5UZtahv6pvh0RxYRcIS6FeAR+cVJO2Eh69
         u3ejYKUAxpeErBHJG7TPJc5kKWzF/iMpv/xM19bn3bf011hIKwpqoqweD1eyH1jI3DhF
         VBVW7Kd5B6vYhUBDsTxbwMfvk7qPP9iGtGHOF+7AtKbWBgGvvDNyppLBfUbqYwU7rldf
         OUzA==
X-Forwarded-Encrypted: i=1; AJvYcCVkQB32EWN9l+XQfCW8fExrBpDVZDdHC4sdS33KX8cZLvZfYesnKw9jPPPW5W3ixXzc35ymDghzvi6tYofH1LLhnME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mmRELdqgkbHmmMKHvlRpyjSBsbUUt6b3dJW7O4Xy+MB2wQHX
	7OwqvIoCxShMpXycuViA5R6tpHS7lhQMhOzbXz8M8Y0B3boOgagp22Ra
X-Gm-Gg: ASbGncvBB4Z/IeHEH8jB8Kss0zfQ/Bj08tnsWEZWZyq27V4diX7QrpI/IzXG8JFaJNs
	GlnlI/HkJIJ9n3vReV80zqNSbjW6mPvSnZlO8dT+4J32f/+MpYYFzp2OuQENRbpAYmqYy+HFTYT
	5Xlf09PGTWZkRvQk1Pnh701DUu+8SlB5xheRXJWwiWIcf7wIfo2qyTKly219pTvDurrOd8Tv9MQ
	B7IKJLLODgAYfLHZqHI0iU+y4suQmlDycQZosGC5FCoC+HpWC7NWcX9MsNtGs6XR+3nPE37hiML
	SYXb7U4BNtH0iIpq4Mlivfrw6KKBaCuBvMugu3BV3UbNPYy+Wp6cvGUsBwbTeZp0YYPpYUfwdCJ
	5jo6bn+EotRbt49wEqaPwCa83ATrBHdYNfrNnKo8XLExXL6DhD5QzJ+C/vb1j60xfHilYHZczv+
	cj02aWp/u6KolMMacZB+5pEcjcdjQOBYQChN5YylSZEMe7F4zhFQY=
X-Google-Smtp-Source: AGHT+IH9QdNew3zKd3MAg8XQ76QMKfr9y+L0i90gdPpGFMiV8Q8w/KZTKg3m0AoyZ7lPvAh4HwpkBg==
X-Received: by 2002:a05:690e:4101:b0:641:f5bc:6981 with SMTP id 956f58d0204a3-6443704bc86mr3412127d50.77.1764834417911;
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.46.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: fix bpf_d_path() helper prototype
Date: Thu,  4 Dec 2025 15:46:30 +0800
Message-ID: <20251204074632.8562-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a verifier issue with bpf_d_path() and adds a
regression test to cover its use within a hook function.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to cover incorrect verifier
assumptions caused by an incorrect function prototype. The test program calls
bpf_d_path() and checks if the first character of the path is '/'.
It ensures the verifier does not assume the buffer remains unwritten.

Changelog
=========

v4:
  - Use the fallocate hook instead of an LSM hook to simplify the selftest,
    as suggested by Matt and Alexei.
  - Add a utility function in test_d_path.c to load the BPF program,
    improving code reuse.

v3:
  - Switch the pathname prefix loop to use bpf_for() instead of
    #pragma unroll, as suggested by Matt.
  - Remove /tmp/bpf_d_path_test in the test cleanup path.
  - Add the missing Reviewed-by tags.

v2:
  - Merge the new test into the existing d_path selftest rather than   
  creating new files.   
  - Add PID filtering in the LSM program to avoid nondeterministic failures   
  due to unrelated processes triggering bprm_check_security.   
  - Synchronize child execution using a pipe to ensure deterministic   
  updates to the PID. 

Thanks for your time and reviews.

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: add regression test for bpf_d_path()

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 90 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 3 files changed, 96 insertions(+), 19 deletions(-)

-- 
2.52.0

