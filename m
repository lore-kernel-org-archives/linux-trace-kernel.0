Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389D2566D3
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Dec 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030353; cv=none; b=OHWNGdw2hEpcWfCsd4s4Fl9Jop9yWlMLulZIaON1G81TvgsPasv4ceHII+kwhINFLtPBLAZe3pFtolD6+TGz2LqgE5/VDkI/UlNUwWj3njVgUdbxpcFdreSFwF/sRPKmNRSMdWuLz7WdNePKAUjKrlPQgZIDyTGpqQPeJFwxsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030353; c=relaxed/simple;
	bh=ZlQkzCF1C8y3eJv+vkyc47wyu4GZ27t0Z1J8dCFjLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtKlCKY61VQUJ5ScIM9JMDy0+rsgsUGLsvPS+i1AFlJ1o31ewUevg44qng9YAPhvfqfuM18vG3Ls6MwE2ukhSpxKiVrL8QhSbjdpB8DRK1x5WnxmF4pI4D0XsZG3Vkda28vbo8OTNwHKFSSIXWSljB6v09U7cYOQnOnXW/NB3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifc/rVTk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifc/rVTk"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c2e5745bdso11503217b3.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Dec 2025 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030349; x=1765635149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Zmv47iVrnahLufmZFWkL2mj+W3enGkIKbG6tGkYz4=;
        b=Ifc/rVTkV8O7dgXCkR3xclpEavYlOXQ4YhBEOFjfXUyAQAa4CCEC+/T3hY4FdPu3By
         0QPA7lzrU7xjhZxn1uDdHw8TIrxSc19+HpPRNv176oLZWCIOkXS2txEB1fzModCAzYwC
         7QBmhX0Xyb3PYqH7BSn42L33IIzv5VuXPrHEjTpCA1xDt51HNfbjrdnFkx2T0o9eZ6aY
         qmjGxZL3nlWqeMExYQ9A/+b/mlJLjTBc9r2UrXCKJalCMHZJSkA+z1/YJ0flD3H7dXJR
         qskTNNY1Jg9RIPL+pP0CUO5QxfP1dVLQtcv28PF06UKKMuXjuc7zjCm1t9zDgyMllgLF
         upgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030349; x=1765635149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Zmv47iVrnahLufmZFWkL2mj+W3enGkIKbG6tGkYz4=;
        b=bjbbJDacdaauwrCofRwI2yjPBFbFvajAelOon3tbxzBb2xEHR6+9BQap0orU75Da/d
         lVdORKagg8DPHkzisA2C3t+PaC2PP4ybFmtEoBpSGR6nXc3d1GNkHe02DVcQwRyK7YER
         BjeqbF6eLd7BKToX0fGG71gTbUWOw4PPPNwCinSYBO/yCU3dkXkcmweb0l/mDZ0P7VYR
         MXDfDHawc1Oj8Oa26yYhPanq7SRwDKGH1VrtWFX+3UkbBh1Ljevr8WlN/A36HiwK9Krv
         Sphoa0beVolN9Qo/oIh0WBwr4aP8PHsxyS3gbNq/ntU4F/Zt9WOigaGsZ+Pl9x7H4csr
         4dOg==
X-Forwarded-Encrypted: i=1; AJvYcCXrQo1OuYjjgXw/zEO5CRMPfXRMq5GAJRI/0jHktculxq3tGb3Mw3+bvuUx5oz7FJsWtfMN36lgT+pb+ZGzzEz9sM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxPs/OILoEs9YqRNR/e203fpLvRfv7Lg0ASDBmUY0OdipQgJs
	Uux+MeCwCQjhNS/NuURgTEIwQ/DYUyFO0nmbGteB8EFmdqNE6Us7vnpM
X-Gm-Gg: ASbGnctOmz0vWDu0h5XYQzRx+z+6LfZMTrbdwZa4x+0+WnJu6lqv9mT9Uc/xym1JAcN
	dpWrR08b4HH8Ggm14yPfufc8otEtFiL97LrP75R9qgiKr3jVU2BJhtjdrMc7M+ewKND1bJa1yXd
	Q9DxmHoNcfHeGBsfELEPxv/B7rMjL/MrX3qDyqQaZKBjtqEAa5VUUsS3xxfW6petcmjNt8Bl8n8
	H/M/3O0mfYWUVmB0Dx4MZjaLpkbwzm4NiRUfcrOySxp1HbC2oSPI9ufIv5dNKV7rFifG8V7MUVD
	DvVmiBsUKCY1u/3GUMlEslT1mYuLj9lR/L0AeydtCUZCCRPoF6pyND4bdAkxSAu2B/nAho8jmKM
	WKXUwqLJ+47jwkXLKBrndepZ5L86E9opzZ2uFIIJ07angEnBDzvJ7fDwJVyqHCRy+yDP3mVtikY
	2sKonUxSq58uuEx5q+v+UDAiRuIZA0zwj7B5FFD8KvuM2myCNCQc4=
X-Google-Smtp-Source: AGHT+IGXT/FkBsu1rpLHAlAmny1mLfVllU0DBntkMVzmVYn+VzFmM0k1kwwxMw8jnzlc+lU/alw6kg==
X-Received: by 2002:a05:690c:4a02:b0:787:ed2a:79df with SMTP id 00721157ae682-78c33b1ab52mr45455537b3.10.1765030349217;
        Sat, 06 Dec 2025 06:12:29 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:28 -0800 (PST)
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
Subject: [PATCH bpf v5 0/2] bpf: fix bpf_d_path() helper prototype
Date: Sat,  6 Dec 2025 22:12:08 +0800
Message-ID: <20251206141210.3148-1-electronlsr@gmail.com>
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
bpf_d_path() and checks if the first character of the path can be read.
It ensures the verifier does not assume the buffer remains unwritten.

Changelog
=========

v5:
  - Moved the temporary file for the fallocate test from /tmp to /dev/shm 
    Since bpf CI's 9P filesystem under /tmp does not support fallocate.

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
 .../testing/selftests/bpf/prog_tests/d_path.c | 91 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 3 files changed, 97 insertions(+), 19 deletions(-)

-- 
2.52.0

