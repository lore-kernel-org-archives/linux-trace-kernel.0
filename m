Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CC1A3165
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186781; cv=none; b=n4GYX5njekYRxtwmrRJuFPXie8rSFSy8auf2zmdY27cLEaDwrsVAj1S3aLu7MPoyKAo4M1xiSXAf32ffldzmQ689d4qQZnHU0Z5WpvA1dROd3qNLDQs8MzIsgPeuQGzhuqzyQTUl+00Z0QL25J7PpCGxaP0BB0dJuTX0ZBVJ52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186781; c=relaxed/simple;
	bh=SA8YBwX6UV/exj69CxLhHvYltiFC6wLWEhuIydTpxus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Abcx5hcIsn1iMG0omiEd5V5yzL6E68bocOsR96q295LTT6vGm6K2fQxKp69+bhlJiJOnHZY//NU7MX1BF0BOfNYCiriVSq+8CQijl7cBQEpYQFs/ila9h67uyJkZ5htvmTZ0rEjyBUELbSY2ABxv+HyViPYtE6dFFkIOKjTin1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW2D3EZL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW2D3EZL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88056cab4eeso7682746d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186777; x=1762791577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncd8iftKarOftKagzkM1Xq0zcBakpgViOG8SqvFntD8=;
        b=DW2D3EZLMhCYEg7/WUS5CDUC8gjTNM77YeaSHNPHUGPmxLJ98Q0DFehyVSoO3JivoN
         k0FlfzsySn9uA6UBAmIz7qyz36z1xm94/1AswpDGs42TuGUegAQ9BEI1imKM94qQ4L6x
         zvsuXPMS3ICQR5zuYTxwWcfgoA0RT8JjkedoGFY7RH3tjVgmmlWPisRWKr1ofVHbI77g
         qYdTQSlcAd4ZGqJU/LnP1rVbSe2Bgv6TUxUAeLqIWmFhF5RBiLqgOUw4uazwICjAWERq
         17n/rS2C628cz1fr1vBKUat4a/Z91YugnM1twYt/rCfeX3Shm8Ee0VwSw/E0CP0nq17M
         +QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186777; x=1762791577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ncd8iftKarOftKagzkM1Xq0zcBakpgViOG8SqvFntD8=;
        b=i18smiVN4wQXOdGoCwWwlvFiSG/TpxXNFtJ68ecbWQB+iCoOKuxl3eMXjxYhh1IzIV
         UWmzE5QegaOy3Hf+IaExPJ1VVXq4mkQHxGZQHc0AmyiZRvAmCxNQmqO5SwEjDX7fhw4b
         YpTMxdksfCX62iE+PULQ/U1zlGTStAGC1GuNyQwycaGdHph8XcX9w0wApyfz9AXCchT3
         o7Aw27/z4avOwccDJ/NhApDsUy9w72d9IMU5prRnvubKXCn+DhbKAiPhGWZ27zcgXuVo
         A5AA1CCIYE0GCmP/tCzzEfFAKDg5hXS/EgXNMHYATqYBKEsbO66weDB2tRQukqBF+yxQ
         QsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbIi5zigIIV1l+3N6GWGDSdfRpr7fXf8q6sFZt9WtVxvVnZnbUtuJsumVUUHbzV1NjI2cXDjCjDN7WxcUq9+YqQX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKxRHFm2Tazzu5jCxWYf0QkCHwA5OnJtkaJ1IkfqxKkAK0+AI
	3UIrdnnjAaLGvegTBYsvWdmsv4H+cSPHuo2BRzb/Izunuv/rzTD8O/Zu
X-Gm-Gg: ASbGnctCw6SVI4+TvrOfxFBGqxQoqOBPKf7Jj/pkr9wOdk18j5OiiZAmV8QXLNXtXFZ
	ltyWM7KI5rp0G4dV67eSUJb7HabJ0gHzSLTLyvYdIrJfx7MLa/3J16nHxQ/wR9VkhsbTRvzcWzq
	ei4Jwo1BjGY65eAspzy+/nezXSqcLZNmLAchCNv5hppUDz0Es6NBc/wglyuAflhtTC6OzgxHdZ5
	8z+fRRxyKl5Jlu4PosfX7dmcOc/3T2gfEVLO9pUqd3bQCoHABEgtGsLT2hreqPdCIDNEi/YxXbD
	9agtWtuESBHpDBRhJNXgEOx51yYDrPC17eQOzK0D8/g1KoNa4oHUJH3KewHH5aSP/mEtxxZb7Ro
	/82uXJ4lnbAQWXFzYB1DcRUDCrvmqA5RNGW+n6i2ZyVHAd9VpoAbFLWDRNQTsr1UzFOp7FC1HTZ
	ZTyxjfcY3JXFTI708=
X-Google-Smtp-Source: AGHT+IEAQfamPC/d0ofEW4bGHVEQ9HHMtZbp4Q8HmqPZCWRtg8LnyQJ/AkABfg86VcVL9UWlrv5V2w==
X-Received: by 2002:a05:6214:f01:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8802f44b4b4mr155355746d6.43.1762186777421;
        Mon, 03 Nov 2025 08:19:37 -0800 (PST)
Received: from ideapad.tufts.edu ([130.64.64.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060eb3332sm4273556d6.60.2025.11.03.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:19:37 -0800 (PST)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v5 0/2] rtla: fix cgroup and trace options parsing
Date: Mon,  3 Nov 2025 11:19:04 -0500
Message-ID: <cover.1762186418.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 2 issue in rtla timerlat and osnoise parsing.

1. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
   and osnoise parses does not allow to specify tracer's threads cgroup
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this
   by allowing users to specify cgroup in the aforementioned manner.

2. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as

       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this
   issue.
   
changes v4 -> v5:
   - Removed setting trace_output before checking if it's NULL in
     `fix -a overriding -t argument` patch

changes v3 -> v4:
   - Removed patch [1] as it has been mainlined
   - Resolved merge conflicts with [2]

changes v2 -> v3:
   - Combined common logic into a utility function to parse optional
     argument value
   - Removed change that removed `clear_terminal` 

changes v1 -> v2:
   - Moved removing clear_terminal from `fix -C/--cgroup interface`
     patch to `fix -a overriding -t argument` patch
   - Added clarification why to remove clear_terminal
   - Added `Fixes:` tag to the `fix -C/--cgroup interface` patch

v4: https://lore.kernel.org/all/cover.1760791697.git.ipravdin.official@gmail.com/
v3: https://lore.kernel.org/all/cover.1757034919.git.ipravdin.official@gmail.com/
v2: https://lore.kernel.org/all/cover.1755018581.git.ipravdin.official@gmail.com/
v1: https://lore.kernel.org/all/cover.1755014784.git.ipravdin.official@gmail.com/

[1] https://lore.kernel.org/all/164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com/
[2] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=999703

Ivan Pravdin (2):
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 29 +++++++--------------
 tools/tracing/rtla/src/osnoise_top.c        | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c      | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_top.c       | 29 +++++++--------------
 tools/tracing/rtla/src/utils.c              | 26 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  1 +
 7 files changed, 64 insertions(+), 81 deletions(-)

-- 
2.48.1

