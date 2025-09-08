Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022D1DE3CB;
	Mon,  8 Sep 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297172; cv=none; b=CwcVRgtfPQpCFB1Dc2JqHSJTNqJyG0zwzGnRmfRdYBcJ8tRamZ5x1cbGN5clNOdj9khj1xMOl2SN0RUSwlUolpw7arGAExwmPyB1ewNmFHKKJlX7mSjseMn5Y+uMGxiHY1WT3Mc4C8gjXiQqjh/jAterQesgObhwpA+xKzQYgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297172; c=relaxed/simple;
	bh=QJOp4NHIEyzIkCa2KKXGFZjQSIPaljNJbYzgbJPvaOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Le7oZ4tbevmHJd4oqZCHQASmaTrop6do62jTXLcwQ31OyB5z0On689dpkP6HhYwETuodtPJzcdgz0jKbAs1WGl1PtJub5M9ejwPd4j9f1l0Yw3nQROO0m6Y2qllOgCEMv54a7hBYNThLH0aftd9ATQTkQROpd7fXmdmwxhj9kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSXYeOI2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSXYeOI2"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70dfa0a9701so46010846d6.2;
        Sun, 07 Sep 2025 19:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297169; x=1757901969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvypTPf2Nmf1gYAAFO6PSJI6JwBdKCqaPYYToFGfJnU=;
        b=CSXYeOI21YRkMJL2Nbq9bFKKRN449wqMt+j73chVxqHdwRBpANbBrwsaWEDhoPC68r
         N/HajhmvyzwF/J1++xP0Um/ie8MX3q8j7pauPhxGntFIflrggR4B3hvPJ0ejSIj/Xbdh
         KvODIyqjkpkFknuMSmHOcEweonnnxndR9YUSs7Nm+p6XAB6rumV4vt3D0KXHZFG7/J8g
         AbIvBBneUzLF4CsP485kzKac0SKTcV3IAjVu5VfWijhPY7KM94LexWI6Q+78jPutDJA+
         zx7CQ0PgHmtBn7zIAXK1TX4d+H9JKPCQ7CXg0CUYdFlwckIXCj6KNIlPa6cX0eTqswFh
         OpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297169; x=1757901969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvypTPf2Nmf1gYAAFO6PSJI6JwBdKCqaPYYToFGfJnU=;
        b=WC/ngJ6ycooNOcGjHQ48vMBABOVlsiFAssNUhFdmvNhWzz7VsGckIlqy0gZLevXY9A
         +z/es60dqZ8RqGxqSPWpOUueC0c93H3ljcIN3Ae9VEOcq/L3+BPKruDOlhqQ5rBmYOj+
         ssPuDUL4xcA29eVPJcqbaEoSQ2sjo1I1EQpvH98rXQPoERb/UmShDh5A16v5Kl6fXlSN
         sa5gkJ6ecUoLRoRN3YwLwAQWHau8PBtP7jrHItukg1Hot+Y/Q2KPPD2wUZwlK7hAfv7R
         IE63NyQV4+JvtvYsEq96afnlWWj/ZNDyyvLiM9gE37Eq8CKQqAD/qWg6SIIN0oi1A8tj
         0/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx/hbiZKmZylmg9MMSgyaz9zwgG/qlZOA3ONvRYXtKbby1xy5RNqlvttIjmglVnukW5o+hdVyNrz6pzIKNUwscgdTf@vger.kernel.org, AJvYcCXCYEzd3u3V9AW6dEvtG4d9IrNFwk/A3+dCa12BnbPtG8egcNWLFlu7rHhvIRwZ0s78ipjPo64af9Z7xx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3/bDdUfJmd1spMzpw2clDOw4VcVRGz3OkUaV4sF7TpzpQ4Iz
	5WLnmoAAxdgXJLl8ZuspXRAJlBkEKS+9nclnff/J/rXQwzGZ/MInMJ4W
X-Gm-Gg: ASbGncuw4/GBqBReiCAKlUOL5gErgOryeWbo4VDYrERhVrKB4+fmND7VTGGun5KKnDL
	syUEmkxHkZw6CbnUXH4YgeaH9Is82xS19xYtEIxo7CfTQhtsbz6zw8SQRy3qgxp2MckRj77u3+j
	WJFcSsUYYUou1WB94SzWIgsgnNTNGic5ExPm0aPwTp/aQ7YWPYbn5Cz31KBvH6NGo+STENPSgJW
	kL6wjIwZkomYVf0mxzhLIb36g2vLQ7CJfxog4lj8FX65HxY4StTS0oxN70BsxL4RFN6wjHKI202
	6906hYZ92oyi2hUihuSFmPeWvm9Wh2zSZRfosJhFo0bmnBaFNTue1OmoH0GJvXMoHv6IXAnRF5J
	59XVrINh12B72MEAcOvGF++4GYyTjp2OKyjxva3YRK1ivbnacwYl+H74DtIVYaekYXXXfO+ZFb8
	GeB8xjiXQ=
X-Google-Smtp-Source: AGHT+IF2vDv/Ts8PcRRIGsz4Znar8p8GM9h8PBCBwYi2ni8W2GqWIceHmXgATvKewaFwMk7XStKkUA==
X-Received: by 2002:a05:6214:2428:b0:70d:f50e:afe5 with SMTP id 6a1803df08f44-73941de2ac2mr81558306d6.47.1757297169328;
        Sun, 07 Sep 2025 19:06:09 -0700 (PDT)
Received: from ideapad.solutionip.com (wsip-184-179-113-83.ri.ri.cox.net. [184.179.113.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72925b87571sm79638846d6.6.2025.09.07.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:06:08 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v3 0/3] rtla: fix cgroup and trace options parsing
Date: Sun,  7 Sep 2025 22:05:56 -0400
Message-ID: <cover.1757034919.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 3 issue in rtla timerlat and osnoise parsing.

1. Fix buffer overflow when using --on-threshold option. Currently
   passing `--on-threshold trace` causes rtla timerlat to segfault.
   First patch addresses this issue.

2. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
   and osnoise parses does not allow to specify tracer's threads cgroup
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this
   by allowing users to specify cgroup in the aforementioned manner.

3. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as

       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this
   issue.

changes v2 -> v3:
   - Combined common logic into a utility function to parse optional
     argument value
   - Removed change that removed `clear_terminal` 

changes v1 -> v2:
   - Moved removing clear_terminal from `fix -C/--cgroup interface`
     patch to `fix -a overriding -t argument` patch
   - Added clarification why to remove clear_terminal
   - Added `Fixes:` tag to the `fix -C/--cgroup interface` patch

v2: https://lore.kernel.org/all/cover.1755018581.git.ipravdin.official@gmail.com/
v1: https://lore.kernel.org/all/cover.1755014784.git.ipravdin.official@gmail.com/

Ivan Pravdin (3):
  rtla: fix buffer overflow in actions_parse
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/actions.c            |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 29 +++++++--------------
 tools/tracing/rtla/src/osnoise_top.c        | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c      | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_top.c       | 29 +++++++--------------
 tools/tracing/rtla/src/utils.c              | 26 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  1 +
 8 files changed, 65 insertions(+), 82 deletions(-)

-- 
2.48.1

