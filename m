Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45250244EAB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157377; cv=none; b=NitbXNwafu4DGKattmrJsirDNEltjWjdGSOUGG+0g37LnUWHgfj39EsW1HOwWy1glZ2TfUvtsumUfNc/M6Wh/3RrayqUW9adpI38fLaKiTpjmsrR9mwjJf+snUBuO/Lmg5NKrNLdZn+TPzNpeH7Q6+lhcP29WeMxkrTpG0cGAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157377; c=relaxed/simple;
	bh=CSW10IqiNdAkspr2IgyTQkreJmoj1lkd5Vs5Tjhn4Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qB3ItwK1Mz8XuZAHmwFzsfUrpXDB5hFa4SA91LeoYtK7F231H+kO0pQ8wo7L1d0aFlXE+Jd+fFayt5m1k1Bp1HsqdFGC8KhcbSlHxdqucUrYcLHtP7QLK2yhRO7QKDyLUDvLaZoXLk28aalEVCddVCKjxJQCjI9MADFdQj3j3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QwFh39Je; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QwFh39Je"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso3295010a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740157373; x=1740762173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDByaDv2MeIoDkWDRCtDD68r/JuubevBl9+EY++FX5Y=;
        b=QwFh39JeqOC/L5XL2f66VTxmJj5cJEme7AAXfK7OIAhcQzpFmYaqe3QFX4KX9mGDFh
         qbNHWeHSYk6JhstjFSsNC7K6aM04+ogSFIoYYv2WfyvLDN3R0y7RKg46xtpVKtFm3Xue
         YhexQFdNPaYEasZdUdakA6iFKkyIbOPLzG0JY/pZnB2aD+buf4yRG0IidRVF42tm24Dw
         TUtZe0CkwRjyZnMzSgxJy2EBRcxkF+V9W/cZoYDVJGAytYxVEMG9s74v/+mUwPc2dXKg
         TIXRy3MEu+voy5q4afxEUFUvSf8dtozHP/qkecmN7AQigSGElxDfXk444p+C5Dn8zw7O
         iFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157373; x=1740762173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDByaDv2MeIoDkWDRCtDD68r/JuubevBl9+EY++FX5Y=;
        b=jVFUysg4FNjHCYu4XCwxS/tNKWkWrBD2lwfguxNK5B8vQVspeCBeYdtB63UjTd1kw/
         xZ7cL+VrP0sohDBfwG/cdZ+xDrRQ/IsP/k3RfsazlArfD7Id6Wbk9n0TxVdLKaG7eRvY
         ry3CxsUqtrSga/9HmzJ67Ju7dpWjInoTP6zX/7belCzjvoq/B75ByMWohxHPH+A1JIKx
         2qIXyvCByQEFGvClBV2Xbs8q6WYdmNWHpywICEVRP568rIyYweniqF3pL+JAEkEzteU3
         Y1ineQNhYVfki4UeRK1ChQ1iy4BpEEPBqcMnnqGtJm5dJSs52i80nC4oXWx2hHwfVJV7
         XM6g==
X-Forwarded-Encrypted: i=1; AJvYcCWv7rYhzG55A7kzFbPWnOKMDk+1TQSM8UCdmC0wxS5exu9gVF5oWIjSmSosynW9bvafy4vxVXBJ/lB4Wj7INE1pfSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkY2KYpUBN7ui38INcqIPl/rwe2k8/Nz0R4+CPuHcukG/bztr
	yA0EPRotW5/0cUd65U663JH0iD9bwA59oAJmgqX8+KkgLYBl3CF1w5K2T+Ai3Vk=
X-Gm-Gg: ASbGncualwlb5N3WE4j2NnnhxQoYuEDg09rBH41s7i3Q9IoISfpOfj1bqe22TZ05Bxn
	z4f8uZz3AQ+Qu+hUMwan/m0rQGP77qnHXp6FE1F12PBOLKFUyaFDfE6d7E5WAU+jAUBMDAFVtUi
	ILkEnjW1zbfWrHaFdCmK9k/IwpdH8dscWlPIZEkQZe8W89vKHcj+3KPedDzP58bggwfzNwqQHIj
	XRw3KBvZEQmWBO/nWFI7kbB+lpcmAYAWMGXRIyV66vjle4GHc1bw9obgpeIgpIcmcH2qmlDIQ/e
	F96ZQ1ZrOeZGbsdUsUipj+tSD2i7
X-Google-Smtp-Source: AGHT+IGfcJwK8DsLRDynNMYZTxbIxb0l+jqrdkXEpzFnvtKSRwocRJ46u22XwIA9pSi82Z9VX3nCQA==
X-Received: by 2002:a17:907:7855:b0:abb:b092:dade with SMTP id a640c23a62f3a-abc0de0de6dmr329918266b.38.1740157373377;
        Fri, 21 Feb 2025 09:02:53 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm1105668766b.161.2025.02.21.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:02:52 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 0/2] Alternative "pid_max" for 32-bit userspace
Date: Fri, 21 Feb 2025 18:02:47 +0100
Message-ID: <20250221170249.890014-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pid_max is sort of a legacy limit (its value and partially the concept
too, given the existence of pids cgroup controller).
It is tempting to make the pid_max value part of a pid namespace to
provide compat environment for 32-bit applications [1].  On the other
hand, it provides yet another mechanism for limitation of task count.
Even without namespacing of pid_max value, the configuration of
conscious limit is confusing for users [2].

This series builds upon the idea of restricting the number (amount) of
tasks by pids controller and ensuring that number (pid) never exceeds
the amount of tasks. This would not currently work out of the box
because next-fit pid allocation would continue to assign numbers (pids)
higher than the actual amount (there would be gaps in the lower range of
the interval). The patch 2/2 implements this idea by extending semantics
of ns_last_pid knob to allow first-fit numbering. (The implementation
has clumsy ifdefery, which can might be dropped since it's too
x86-centric.)

The patch 1/2 is a mere revert to simplify pid_max to one global limit
only.

(I pruned Cc: list from scripts/get_maintainer.pl for better focus, feel
free to bounce as necessary.)

[1] https://lore.kernel.org/r/20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com/
[2] https://lore.kernel.org/r/bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt/

Michal Koutný (2):
  Revert "pid: allow pid_max to be set per pid namespace"
  pid: Optional first-fit pid allocation

 Documentation/admin-guide/sysctl/kernel.rst |   2 +
 include/linux/pid.h                         |   3 +
 include/linux/pid_namespace.h               |  11 +-
 kernel/pid.c                                | 137 +++-----------------
 kernel/pid_namespace.c                      |  71 +++++-----
 kernel/sysctl.c                             |   9 ++
 kernel/trace/pid_list.c                     |   2 +-
 kernel/trace/trace.h                        |   2 +
 kernel/trace/trace_sched_switch.c           |   2 +-
 9 files changed, 70 insertions(+), 169 deletions(-)


base-commit: 334426094588f8179fe175a09ecc887ff0c75758
-- 
2.48.1

