Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB99374745
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281462; cv=none; b=nzCWii7/BtPO/P9PZAaWEZ0JmP5lNrcuxbswg2VzlhJwibmuwdRNBmNcsMGMp62QiGU1ZJgXamTGWN/48IGJvGmFBHk/+9up9FYMf9Ct8kMBTgSbmDieF6clrhfqKHp01ZzhWXTR8XtKQKSNiUSdnvvNkmgswfAISSRWOZhBvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281462; c=relaxed/simple;
	bh=EaOmmJJC3kV/y6g1/KOXknozM741k9/ONn4JSj6RC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWxz7gJB7pjtF6h6NLmadVrEow6cjjjK2ifaofKShn0Z0Pvq+4vYglBLBAZlbf4z56w5YsFto3RsHoaDo8IndgpeefUYhAXXya8KwdoyGknkx+vPiF75o5MkAJAiAUgx2JHSRZbTAUHznTb9L687XtF05/tsJnmSOHct4vq/MY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSXMDBKV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSXMDBKV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1121911a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281461; x=1789886261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5b80pzerJ3gCHaBvR30moKiKA9qUlNZYajnhJLIpzk=;
        b=RSXMDBKV53Mxv00PbK9pY2sSlvbF22g6zZeBxEImte0aN4+sTw1ycWwMEwRyX3SsNF
         2U+xIikziij3JH6Jo11DO/jjoKva+K1T3vPamCFdJMXdh/EB28m1bbYjRZo2L9dBpjUy
         b4l/AXYFO8RkmpfqU3nUWagew7pPSASIhVqCaYzHqUqh1khBLq+38m+dkMJm+uzkyQMi
         e55Lqpzf4jpDAWPKJbkjJlj4BzhEzhZrMgikVspPsbDprND/VV4cReZyJdprrUmoCHHi
         bpkbb7FIbrtVqy1Hf8hONKMdUmn1jfEMj/ZsQDzEetOpkMR29Pyz75QcoRXFrZB0RRLU
         CGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281461; x=1789886261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5b80pzerJ3gCHaBvR30moKiKA9qUlNZYajnhJLIpzk=;
        b=eGlgYpBiMSdQtM+UUwCbvqUUCgHCuAaIBB1x5JYJ4xHsXzJHpbeDYUEaG3ZQOdHDET
         dGMiBJOTSStxv02h9I+f7S92zIMJIcPqMt0ysq2SX3+NL/BpGnCGhR9btVCOVKDGDW2p
         V3Y9aaDB9tMoGyP+hSw6DSIJXXSF34iL1Rk45LbffkIyY+xE50LN7vI5lxaZPE4KzfZq
         oF0Z3dqlFD+Y8gtfyPt+KQTDwNmIdS7JRHtDIJcS3Q4TNLz8PM/8Z9nMJxk+tLruK+D1
         f1bIQ+bStzqcmYaa4ZbQAT9cxvkK8oCA+vQjBjp3PeQXMrlmOxrrvKSIHeqPtTJKHZ9d
         L6EA==
X-Gm-Message-State: AFuF++m0cKckEDLnxmqr+UPbrmleM/1LFNpqZex5yeDSv6CqI9Vz3Zrq
	Jnhqj/j6NMpf6Hs0CNh5rfFBp0OD5545Vmuy4qFwevQXoxWiU/bVl1s=
X-Gm-Gg: AYBFou0c3DkZmErqVOtq69oncnFph5iO8HJuUYyP6XtUMDo6T6Nb8munkdTpwkn0Whr
	2Z7J/dTM0IiaGQog+9CxqvU5p8KCP1HanzZaYinid3U4hdO+DUyEaqzCoJzo4xx7eKDEUD6Sx8W
	CUghWbMA1K574myFF7YexpnIio9WD8vIURJJJHV6yrcSF+XmT9nuJGiWrE66TTaez6HUcci2+Lb
	yJ+Bu+K8iaj+PYFQq0FLaZfJoS2Bju4bQd+Ls/8ST6hnQgjQ+AqneYl1JXSPunzq05ek05KD3Pi
	pn/zNHN0WVfzA9CHtp2tlKMwDmmY1epIQzP+cJ5g6b72rZTWdsib8KOXSHaJG6zpy/Om9WViI9G
	9ifUwpvgNwT4QMhLlScREoVrZQx3xRbsmDh+eSAmfbQpSPNgeySfac+8Bi+/lzg+yancjKvLZOF
	RS9QNsGAq0pH1vqBdWJZPTc4yYqta34hYIONKLYQD/aIMy96NzttexyltleMODFaNZp23OM8nwS
	KofqsZWiTm3bF8OZ/rNOj5GcQ==
X-Received: by 2002:a05:6a21:6f88:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3daed2e2f72mr26462406637.13.1789281460900;
        Sat, 12 Sep 2026 23:37:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6585f94sm3253291a12.25.2026.09.12.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:37:39 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Adriano Cordova <adrianox@gmail.com>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] blktrace: build the synthesized v1 record from the entry's own layout
Date: Sun, 13 Sep 2026 15:37:34 +0900
Message-ID: <20260913063734.708896-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913031030.E85191F000FF@smtp.kernel.org>
References: <20260913025827.457116-1-donggeunyoo.kernel@gmail.com> <20260913031030.E85191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 03:10:30 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Size-based differentiation between v1 and v2 events causes v1
> entries with a large PDU (>= 16 bytes) to be misidentified as v2 entries,
> scrambling output fields and truncating the PDU.

Correct. A v1 record carrying a 16-byte BLK_TA_REMAP PDU is 64 bytes, the
size of a v2 record, and nothing else in the entry tells them apart.

v2 drops the size test and depends on Adriano Cordova's "blktrace: always
record ftrace events as blk_io_trace2" instead:

  https://lore.kernel.org/all/20260913063155.708520-1-donggeunyoo.kernel@gmail.com/
