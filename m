Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260717;
	b=MGe6T2GewWCQNat0/4bMvII7aZ11X2/QLB7fDikWgJDiNnhlqShvutffyVupLnacmdRF
	 oB7ao+GXsFkL9/hzD81jCjjFqfyRH3lQSu92IpXCavQ5ZTBOjeWCo9QTThCRnT0VWob/K
	 nA0YxhAgMsP/M8/7sebTaBnVdwOVgQSLa3gKQe7NoYSRa+IjW0FRn3u9uLZRdF2tazDj4
	 0vm3Cerz8uXjz9DWSCvfdBk+ZSpODkQd/45BDpXocDTJ2GXCUrvTCAGEUvp3mbzZgNbbI
	 wfh1R6apRg0uIuzz0vThV22evPO17CM3l43x8P1KopFS0E6Sh5cQtJctlfThS3CctqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uJoUjIzEXNDAEnMIiFt3mSA+8sQT++LiAspTJMDWhHo=;
	b=NwJN/mA7J32cb0Wv0Su4Sa31+4HElPZtaeKzhrKZf3R30ybmt6jalwKky3GS1EfrS8Oi
	 AA7gMSkuzagiLCExtYVZUv44mkbbBS3eU8iqztACXNi7GYMp0iv50FBJ0Oen21fm65aB7
	 SBUVKcasD1pe97aOBVwWaHJQnKsnFXQjOKXLkgzaKg4PmBDwUzpf0uKBdeWeQlImnMLJ8
	 Yl0FIBjqfmRKakBXM9P3Wzl6PZmhX5VF9L9tdehkUw2yLZDobd7NYeEQ7X4/h/dHzW2wE
	 mHMIosJK4wBRNL3oePCSWgBH25WFLoxBb37BokuL7KE/p19RcVcmuWvRu35zJUWn+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBa0FiB8;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C9606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B9C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBa0FiB8
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1069414a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260716; x=1795865516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJoUjIzEXNDAEnMIiFt3mSA+8sQT++LiAspTJMDWhHo=;
        b=gBa0FiB8PsNe4JTanW7Fjep20sFS/J0Lxxjo+fUS4Z29TG8+k8dcKaC+mTrimd06M8
         NCqqzeTcFuaWEjjnU5757rQLxeK3C0VCwKXPqdAT8+kobLrwNMfwsZDFavvDZ/Q3f8wR
         tf/o8FXd4+eSP833CY4cRGeYRBWZwzKFfRu7IGrXu89t/p6TX5zgaVR2/4lTLtxVJa6f
         GQM9xKXIg6LdJmha+5kseGkvP0DTy+Q7u3t6QbsQFH+zMLj/d8y/zFTixyTQqKNw4g+I
         cYN5psGHnDALoyqx9UqPJ34ozKyxRkHN9Nr4nffJlQdsh/sIzJ9bXc9tZSHSPPOt7rEo
         cKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260716; x=1795865516;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJoUjIzEXNDAEnMIiFt3mSA+8sQT++LiAspTJMDWhHo=;
        b=ZRUXd2A8v2LISkm8y2CogKYkxzdVlPSpPIRqdcmU5flw3tlnfITmd+v5K5dVq+Fjb3
         7/A0oRnibJ5zw2PdROd6Hh9GF5hXPKbB07/51yAuuKDxza6KqYCX8rfxZyoSO999nhRY
         s22y/SvZJiS/mJs9SqKNo9LCNKJL2DNwMkAhy6o5eJpoEADXj9O4HRTAqQQtYJrYqj2w
         /4t7lWNpbFWRDYoPXEFZW6KAOJyXwkPDbFZeIzfyAc6kravWF1EcdxtEoDh6zN2+UNwQ
         tqvp0b0ogoSY3viQMa+aqfaO7hK24iw5vZacUQkWgl4FDALKmgwVjTjI8b4/UjN+NvK+
         r0XQ==
X-Gm-Message-State: APuU4Z+GKzZPHfAtNRM7xL/yc5a1E8xBfifsMX4jkbIA/j1kDw0+1cLU
	S0/MJxCdkE27lSe5s8/ey6SOdH3XNMftvzkoxoCxhSNfON8v+SDmGmjM
X-Gm-Gg: AZFdTZe3Fqkz3N/6KV3yAd6Zup64uM3d9iwvI8DhiNeTLDSRvBLt4u8Lm4UbSkMqJF4
	H8dzMXKRUbDgzo6K5QbpbbbWyVMz1GyRoil3ktIgdgFnIj4iXKLzrPPbViF7YP5adMpibPsBjRZ
	6qn81e9C7xq43K+Nux6k3xR1jV3lQ9umYAjWbA3Se2dyLMu5+IC9PK9Rq2LU+OZPtuiK/C1UXX+
	1/xCbLjZP+cPFIpn/PshdXlrOAVJzRxN2g0MNAa2P9K+P9VMTyLHoZrtPpp0xvDtJRXBiNtkJNJ
	NX6nzU7KkAEW0XLEqWpCpDNI4PgcE6ICO8YuMtxo/oRBX3CF/Y/rWVGseN6IxYrsIz3+NmmgNY1
	y/cSA7KjbtUAmhIvFAg+Mzo9GLvUnnPG4NvSgge5FLUhgdzHEsPl8gXVeGo3iNUZgns2vo5UoXO
	Tn52A2aRU93c0ZY9o7iRY3Y9QcEI6l/Ess6fpeZTpgsqJZHph86zzGDgX/iSWZuUSEumqJtFjyE
	Rk0X1Q4RNH/EpepMRg1k5f7J4XVkC0lR1Q2C8j6NTPjYDHHWLEK2R7j6akJ2ZyA6KKLHP4cgdR7
	exH5WeqDlgnS4meWfVamwQSWAlNCC3faL2FMcKqALQ==
X-Received: by 2002:a17:90a:d885:b0:3b4:6094:2f9e with SMTP id 98e67ed59e1d1-3b4609433d7mr512432a91.46.1795260716393;
        Sat, 21 Nov 2026 03:31:56 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm11100535a91.7.2026.11.21.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:31:55 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] verification/rvgen: validate the monitor type
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

rvgen takes the monitor type on the command line and pastes it into the
generated monitor as RV_MON_<TYPE>.  Nothing validates it, so a typo
produces a monitor that cannot build while the tool still exits 0.
Monitor.monitor_types already holds the accepted set; pass it to
argparse as choices.  Patch 2 covers the rejection next to the other
error tests.

v2:
- Thread the series; 2/2 replies to this cover letter.
- Tag both patches verification/rvgen: and capitalise the subject.
- Patch content unchanged.

Link: https://lore.kernel.org/linux-trace-kernel/179447882046.254241.15114935256138596418@gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/179447882047.254241.3226415982233977960@gmail.com/

Testing: make check in tools/verification/rvgen -- 31/31 pass.

Chaosheng Qu (2):
  verification/rvgen: Validate the monitor type
  verification/rvgen: Cover an invalid monitor type

 tools/verification/rvgen/__main__.py           | 1 +
 tools/verification/rvgen/tests/rvgen_monitor.t | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.43.0


