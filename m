Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9561BD9ED
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308817; cv=none; b=YFVMc10khQlqBjVYgDtjWMI2jpV/3nRBODkr9Am19NSeJWaXA3J7bY47yJrwlJRoEZ87R2GySmmrWpBHy3ROHnjvirHtPxwajhYBOa0zHXX4Y3QKE2LxaD1JDyZeB/uUcWlJvUtOMctGSWAQ5gSzTcIwynfh6Kntpkdh4UygxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308817; c=relaxed/simple;
	bh=gxaWEGY6OQ4tuNoSTe7NIiwN+sNJjFe7RPhD8VYisHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OU754Nnp+ieaEqhFE/Hby+EBaDvIGeVpTVzLW8yWmBekhFetsenip4ihLF6BAzCyQCJXyr7DScy2byOHFwSxWwcNTaYRfPBzAk5xjWzsYhHBFnvPjFx/XNQw2NAX6rhMQzmSdUUt31c+kSuXJ83XplPyqQizZss+lyH2HTQGspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGIX8l/D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGIX8l/D"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so145184757b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308815; x=1730913615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=TGIX8l/DsFh6IQc4/QFGJc9TCcbIx+7+2kn44uuFrhYfDPGWxqX8Z5i2ByMCzaROtV
         vjOr5q1VhgBkE8yquSGuo8yIn4Hm/Vd/BiT54ZCtITeJliLtn/PJVywBCm77XFE/zhEf
         TRa4xzkW76M/NLrgHnUn+PjN3h4lzzk1dyxoaiK4PxRNvdiXKYYN4iAhfhi2W7aWngcS
         kVqXcH8zpOSOx2jmrnrCXbrwShmM5lx8LMj7nwjCr4gaHXXZAT+TfRs07lLi+e9dWzvf
         mEddM1YuFd68hgedw6tPPBjbCrvts/94udQz7umgiarUJgbdbkWdnHHftra4g2S82fws
         tRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308815; x=1730913615;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=Y1dX7dAU1KPEZqyNFmDrPTymVeuk6ecUbOngjEUuaeINVYGCHk2gmBQAou9eHplJ5Q
         CbSqzDTiHwNa4yuoSILGaXXgrM1ZAoH6CIwB3GCW5VwUwH8yPn7UjewREjq1aunddhg+
         jJqUrWs9hMAcq/3vR9T/zAsv9is8dS3KOgGH+USi0RCJIqkJ5GkznJqNN6S1rnEoL9cQ
         4M/O44MbBRDOAknlogxzc6amc6En6T2rMHGQzXQcmbnuAe26hqjh4PY25wEddFgdmsPM
         dgJDQ3kq2R1ajD4heYnYXVE2FrKTGBQahnu+oxpyqXonH9Thq5N27V11JEpQ2KsJ8Sws
         A9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUef3gfa9+h61scH8HLrcaI3g3WYYLrbeXUuxIqV7cwYgZcYvE+Q2txHrD8Vc7uLfXXSet0ACesewA0OsTufcyJMDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWH+zqGs5REm1YJ3VJeLvdEKEA7aI42N/uXXanwLmN6Vrl5IJ
	b74NI7rBsD+i5WT7DJqAlJbdWt/13Ba+YMp+RHSoUKYkMC4Pu5oiFLcBhYf6T+xdsETah14EfGo
	SodWSE2Twf8hNUMIX43g7tA==
X-Google-Smtp-Source: AGHT+IGBpQPuMEOVpamNolybCR+mjTbMPDt7+NshVJpSoNsW5gjRbhZ3g6gIduYS77bJPcwbAfWWiWqoJEWjy6Vnug==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:cd83:0:b0:6ea:4983:7cbd with SMTP
 id 00721157ae682-6ea49837d4cmr283447b3.7.1730308814679; Wed, 30 Oct 2024
 10:20:14 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-1-kaleshsingh@google.com>
Subject: [PATCH v2 0/3] Tracefs mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is v2 of the series fixing the tracefs mount options.

Changes in v2:
  - Update the commit descriptions, per Eric and Steve
  - Fix ordering of the patches, per Steve

v1 can be found at:
  - https://lore.kernel.org/r/20241028214550.2099923-1-kaleshsingh@google.com/

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Fix tracefs mount options
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test

 fs/tracefs/inode.c                            |  12 ++-
 kernel/trace/trace.c                          |   4 +
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
--
2.47.0.163.g1226f6d8fa-goog

