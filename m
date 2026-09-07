Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92E3914E5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799180; cv=none; b=WCk886960z13Eep+eZFqSrY4BsDqmLnVnvj5FDE1o0TZfz8YpT2wDjoxIJMuiHI/180UE3bodMv7YBZ5NGOFihD6uPcJq/j5wjpEJP9ZVm6wP5suQnBlqslyHrI+/jge/K3+gG7NQuim9jOO+tSXvNVZNiM6HlCGvpyT6HDT7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799180; c=relaxed/simple;
	bh=JScLvDY1v4ZXDmdRrVKEysuuyxpgWjgoIm5gZeod+cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqexmywoCainQTtjdOKZsdyvgFti2oHwwvuw4oJ8S8C3JfD8c3zjaiN+s2cm7x+QGdl6QQL34/ZPyWmxCxd/JcXWJflOysCrNcNKpWHlomHYFBbTj8Pjs0OK5VfvjGpUvOcwYJ5I3eDU0tN6xawVKQo1QqWlYSP/+1ixY573DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZrfW8Fd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZrfW8Fd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2544ff970dso507364166b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799177; x=1789403977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=gZrfW8FdDX8V0jv9m6KpwNKdrnt4lHPBlDsIEuo/LaVewlK1+CvQs/UHN3ZaPYfVsB
         HJV0VZeEyNTKTUF087+sbO7spEpAXS/Wdm891jOjqbSH6BQqgJidW5ZSKVQySIHqznzL
         TmcqLdrSRymDQyBPMPNnGQO304ljoODI0Y8GTIRHbVWtOrjLtP1+0WOJaEfWL7GMGm/r
         Vg461isbIpI8SY6exvzD94m+GsyO7R1yU3B4gwDNhGRsdBqU89KyzqMj4iHn74mJF8ds
         5wF45BYdDxtn8FLsfSh6dFcMxuS9vxBnuLUqimygEoRTXGHfMN4OcsvXS5eBvzPdTHbT
         WciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799177; x=1789403977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=nLOCE5B4Yr7Jo6pfA8UaMTyytcGv1cbyU8Ov84nDu/eXlwuryXMCqJufbzApd5USk2
         EG6YBmk9uYn3thOL/DLAMjvQoJzl/uV3UA29DTdAHzqxH12eBVTHnux2KbbIMFuMVZUG
         i+OPyFvgZcJLEKR6HfXcM4hSLDUUCeiKZQEo8Vey4KPmOIBKaLKIIuFPI+HuMydbCUAh
         I3KhyDPMP0jE1del4OJFXchd1dI9f8PW5r/9lzZu/Adt1Sph4AI3VpgR1jYb0utlrCYm
         67FoXoC6XwS6v+nrMoDlcvN6Bvw749M1J+KOxJM1qxvNulmdJxsT5e1CjR+/tNzXNwZB
         fjRw==
X-Forwarded-Encrypted: i=1; AKwUvBzYKf9py9yb9Vd3Q9w95oR6wqGtHXnZcrIN78PyJnsH5j/8OkKKvodkZYzu2molLef/Ko69Mx2af3bzM4YkdvKzC6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mmycVHpw+OQStdqo9OsXuyLuTCstKfKvoU/x5I5xvo5D7qmf/i
	0kyKHosBMTreHYK8KSCWzMrUGZ3GfISz6qOLrnewYXdgf7pdNjGOBt37
X-Gm-Gg: AYBFou2GYgepFEZSHI28QEC7pjIXs6eoFEwfUzVs9PFcnuTNpILcin0TGPBowgHQAwt
	F3AINze5WfExs8qPyHR3nWl5AkRkgXxGN0eGTVpiUORnj7ptbZuCFO/1ClxaF9I3HZ0HuAalxGb
	h6oDqq/Yv3SyKdckLu2NlajyIh5+A83tdj6nyKscrhL49rGd8O5okd0XdgCDLMKw9B2q76FWAoW
	Wpw/jDd1z8oF+sQEWPYwgu2W811mH/5UYFKeF0KFCsFxZoYGBmK3id6dZ3ff82E5NTsi9Zjnf6+
	OZ4AUFpFryIdEqpy3ty0+Pg+7XfsyPzcE8j/xs6F1k7bHe2Sc20pryq8ohSe/40FKWnvLb6lhYq
	F+f8KOpLDrP+oUZerAfHFsK40MSxiGYjnhUw2lA6+rCWbrdZooz/cs1p/aeKOL8ConH5qSAYs+Q
	Dxr1XDFU5n2cHjtSp707KfxkkaStcufd0VqeTIJRqVZqo0O6Hg/qJYO0CEHs8KBYKYYSMzClKKX
	JXruj8keQ==
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47b6 with SMTP id a640c23a62f3a-c261649567dmr733976366b.44.1788799176674;
        Mon, 07 Sep 2026 09:39:36 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b89sm483434766b.10.2026.09.07.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:39:36 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	Ingo Molnar <mingo@elte.hu>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 5.15/6.1/6.6 0/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 19:39:17 +0300
Message-ID: <20260907163919.183961-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902122613.442176-1-alexevgmart@gmail.com>
References: <20260902122613.442176-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport fix for CVE-2026-80689.

Masami Hiramatsu (Google) (1):
  tracing/mmiotrace: Add NULL check for mmio_trace_array in logging
    functions

Steven Rostedt (1):
  tracing/mmiotrace: Remove reference to unused per CPU data pointer

 kernel/trace/trace_mmiotrace.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0

