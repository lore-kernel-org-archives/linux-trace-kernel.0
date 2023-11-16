Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+gERTjO"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84347D68
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc316ccc38so10929125ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162490; x=1700767290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzF2ALYUXgtOOWHICjx/9sp3ZlXGizxmY7whZwnkVqs=;
        b=k+gERTjO6F93q1lS3m32rhR1J28d3mpm2fohBNlGcICYiGp+WYLpMxD8T7g/NwYvkq
         TnISjy6v2HHl9uLVBPS8As3+3N6VKqEA9rJCcxc1hfXLgupG0st4Nw0XKCMTajq+7gAC
         fZ1sQBFKSupkE3fCKaYxdMbwZ3O33arR2wFwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162490; x=1700767290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzF2ALYUXgtOOWHICjx/9sp3ZlXGizxmY7whZwnkVqs=;
        b=DWZGf+UWu/D/TNM7KN0cSPYM7vVjppJMqGmMXJqTHsII6Vn/9CvDSkIc1PHSzqI8xd
         89elRnWIkmFc/dqnd6tGsjJD9j6loXJ0lQnFRO4ueKQCMjDryUljXQyLm/vkghlp35Ih
         WnpEi4mI03fP4UcTcnY1C3GqTJpoGU8xUEM+HFNhdPARpiUnqqatSpzGveuraPQ3nL4s
         uHGFLuiNmh7ht+zCSd5uGTJy31uh+c8pP6Vtqp1CJbODVUzK/7sd35rF9ZfuUjdL1AOh
         DiK476lxK3XB4NqSDtR+z9B2/XGGXdcGByT1+1qMcRwPvZPMl/WI8TH/duYomaao+6rI
         lRxg==
X-Gm-Message-State: AOJu0YxGiulNyTIPzRmOqdlVCqkaSHtLv7yh0ATrPzf0yvnQ0xeCV9Ee
	y5lCnFzKzxXStNO+euh6+z4w/jU3exaTK4udYnmnvg==
X-Google-Smtp-Source: AGHT+IFOsmNi6M20q2mMZfgvvs7Ny35X8FWHOzyId2w5LMV8GyUNADT9qbMocFM5IvDg5rKoPH1waA==
X-Received: by 2002:a17:902:f54f:b0:1cc:4eb1:edaa with SMTP id h15-20020a170902f54f00b001cc4eb1edaamr11388254plf.51.1700162489866;
        Thu, 16 Nov 2023 11:21:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709028c9800b001c9bfd20d0csm17388plo.124.2023.11.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Date: Thu, 16 Nov 2023 11:21:22 -0800
Message-Id: <20231116191718.work.246-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=keescook@chromium.org;
 h=from:subject:message-id; bh=w0GAtTzgRNL9znjaphz3FN4VQ24pFDHc0eBL30sFkpg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmu11zVyAR1N094pTJIYi2lpml53vIr/7Zkfb
 zgMf4lRuPCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZrtQAKCRCJcvTf3G3A
 JqcUEACow96whY2PXsoj9tPefpjj3UIwlfJ3ut/35CSfyT8UK7/zYhv7KEZrBeHK/qxMRJ9+xBe
 Pc7j5tIqc68ExBPJVWjYfDJ37dsg28n4AbifgDfF4Tfr+XD/B/7zBYlbqa+YfKIoqNsie3TuEmb
 Jo5TNLzmJ+iHwLZQBg52HuTJ8IypsNdhdPUDt+GSVayHbFP8sOaZMzSgNzkWGE0EZPJVbhJkBhG
 dgaf1he3KcoFhM6lOXcJzNfLL4wP3gW0wQvCa7n53dwozdUYLAN8vAo99ju0ONbxHC5gaRy2hV1
 m8LYlDrVzBTldqKUPCwLlfworllGmywSzRyIvViY2SKCuLTEJMhrfrRT7eIc9F/TyhwKXjfWGox
 Q4MGthWvVnHSVXW26aJPBCdBexdQe0UNHIe1e9GtdPVv6/DSkPteLizTSuVXO/m6gY1q3uCYF9G
 RsrfA76ykmz8PiMZ1HwiSOUivMyMCZYd9dgBIcnKAxJdRmYQm6zmTcEY6iUR4P/ay56A0T7/tW+
 SIqHoC9vLAMJk2kagkrDUu4Q7FIjW4MKeI+Ul2jrc9WW0ggDCMFFYhz9oXzEcrakU5x04mo7l07
 mIs0IZlQmu6Y6/xTB1XcYB+9kCsQ0kxxgVUzqWsljvkctWg0ATuQ6HYRvZxRPR3AoAIvMha9INk
 Mb18F4pb gdKumXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers.

-Kees

Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c             | 53 ++++++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c   |  2 +-
 kernel/cgroup/cgroup.c      |  4 +--
 kernel/cgroup/cpuset.c      |  2 +-
 kernel/trace/trace_uprobe.c |  2 +-
 5 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.34.1

