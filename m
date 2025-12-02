Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB6207A09
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685199; cv=none; b=FwSXRS3TL/e+rUlEqbiIOPVVt7Is2hT0CMxVaB+YsBt8mBSXKsb6P6cC7cpL6J2hISpRdO1Jpg+ASsnunQMt+XAzueWZj4lkWY35EwCewPpuDEdnJg/d/4WKxJsIUMfTDe2F82rUKculPKItEbQSUdF7djA1JLdmbUpYbd9nYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685199; c=relaxed/simple;
	bh=TvhO8/wWsryTXGAN0owlp5rKTKABTyepxFYULy3W2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSkuFN5rxsvy3NH5cc036DF6CnsedYEr6r1JEcWJLHk8WvGl7InmXm9lFnapW6MwIW3HiO4vtmCvhMAXPrvrkCy6xglLz5rFlaggFwbOdZGgyayGkHItRPeFNaFQ4XFI04b3YqBe3071Jry6qvQzLdV29c3vFNpo0gYrfehTAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVQNfwkS; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVQNfwkS"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6432842cafdso4982035d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685197; x=1765289997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=IVQNfwkSQTVE/cj/HGW3SAvX2ZCamyuGLhFtiFuage7RozWddsEOXUfEDDgQzzJCsC
         /IYhg8ziRD2jvu+wcokxqSUaP+ROWGJL6MFEQpabuZdXR6TgHYZp4D9idQYqw2qukBfv
         cYmv0E54pihH6GK6dwn4NXaisBOPkVJpvGUmvX9rKMV+tRo7HWejyjtZHUQewniL/k+J
         k4KGmuYyWq5z+Y0D7gaCxQ5ngx8QY5KiwNtBjRakhtvj5XpmCvVaL67gqkYJftzLGN/F
         8Q/Tgx9zK4YVyR5wEryhItze4uAGhmlrhSoIoX8XpmlSXpLoVldNAM1tmEYwNMgApsSF
         uSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685197; x=1765289997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=L3/Y3qWUx9DHbdnF01wMhh9VsKdpJOl0xvyu4SZN3bFPLDbs74jirCAg8J37yTEeoz
         pLgoXN7e1IzDsQspqhypE/Q0DT3GKmJpf7EBESSEa7mAIWbsqJFuw4JQa3VQ9KxYAVg7
         Ij+4LDzF8JxqdBDxSn0X8GRnNZKemPDy0tkn2Td1z+HiGGkgD4B4759oC3a5jZjW9SQL
         9nwsU0gu3zlJXvdcqmTYgYleYST61XWQMjW++RcxwllsugzP1A4ygdJ9zNWcMDclLBEp
         WjPBOH8oKuvbePRTsJ9O+q2uipmkle5f9wx8+OmDvRp6y3RtL6al4g8OU7aiquYAHJsp
         TgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZqcRKWEbUWQ0lIf+Pm9G6bvQgeqpwM+cRRkxEm6Egkmzl6NY86+w/GfYedSOekB+cc+Dn84I33XdkI3s5xz5vDno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYYpTb6KnseXp4Dv21E+g8wpGZZiiGGSNHe/Vowsl/nk/P6jT
	la3ToSs1mtgPiacpdzgM0CXlIPjuuGLX1WXwVqL2dOA81TPNjwefY/dH
X-Gm-Gg: ASbGnctFBNL3H2KojMb2iRFYwzc/oHLS2WipqfoBaapQVYI11XYDgHrUmY4E3EZ4zks
	SIKp4aNKxLr0KPKON+XkIGu7sQjvdPorsMlBc1rcdreBTBySC7lqEysyWa37o6/vr55c+1RXzM1
	lXBrWg10wY9Bsn8EiAs2lQO0LXt4tf0QcOm19Po4hocZ18IUh4K5h///y/UPDvI2oUzNAR5K/JB
	VH45hdxtdZlN5O2bj5wH9VT8MIUnHScCD8A9YP7wDlCVqnlQsfOuKMxmnZ0mIFcQeLoI3qLj5Te
	5+rS8U9UwohWdbM5eHY9WB3EB9OxL5aEXCOne3dmgxcaiMPyUB/V5EEs+5Fqrbq2Vq++jNbE2MH
	mYLmikp4uaLzxkqTEpJSbrJ9s6EKQXRfDfz7gYTqXumDLLytqJo3bUKSzPTWatj+41B3eVdrbAT
	8sRS1YSKJMAVgo6PDsjrN/zQIrEyjcnzEhGWD4UBl4/5MyEIVbqrWqQjZQDsNk3w==
X-Google-Smtp-Source: AGHT+IEBiHZjjwJYZm4wcRsjMQxrAiRlrUNXkeZHkzrztMI4TVsP7sWW8UWzi8YGWUgGsSgqi5H7mg==
X-Received: by 2002:a05:690e:12c9:b0:643:1a78:4492 with SMTP id 956f58d0204a3-6431a78497dmr23565216d50.81.1764685196722;
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
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
Subject: [PATCH bpf v3 0/2] bpf: fix bpf_d_path() helper prototype
Date: Tue,  2 Dec 2025 22:19:42 +0800
Message-ID: <20251202141944.2209-1-electronlsr@gmail.com>
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
regression test to cover its use from an LSM program.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to also cover the LSM
bprm_check_security hook. The LSM program calls bpf_d_path() on the
binary being executed and performs a simple prefix comparison on the
resulting pathname. To avoid nondeterminism, the program filters based
on an expected PID that is populated from userspace before the test
binary is executed, and the parent and child processes are synchronized
through a pipe so that the PID is set before exec. The test now uses
bpf_for() to express the small fixed-iteration loop in a
verifier-friendly way, and it removes the temporary /tmp/bpf_d_path_test
binary in the cleanup path.

Changelog
=========

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
  selftests/bpf: fix and consolidate d_path LSM regression test

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.52.0

