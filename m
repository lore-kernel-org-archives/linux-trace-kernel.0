Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307723;
	b=QhR1Ugc2MBS6YpVeX82wASxOyQsZC0JV0bUBv3ZjeVRavrvQ0ozKsIQ+Xh1e77KeW0CJ
	 l1oKS4g4/GtHAsMIaFWQlHR3Zazq5wAo3WLmaV0bGUnG3AHSX/R5Y+vO2MQyUChF07mSp
	 /wFkhRT8eogy6L4vJnCUKTLoyKXTn77ex2yDRQkqzXQcGEvC42jVqAP132QthS3R2K1Fk
	 hZQuq6IpUX3OMaXi/ltDohmQ6GtfZ0Mvn3FOnuTAKsOhE52KWUgpj1Mb4xxPb5nwaenpB
	 dl3f7FBhFhXUdsR4sPX+ZVwJIaF9+cLAUXRkWd4Y4N+IECz02y9/DXadfZ2U07Z1wbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kjaMl1GYSNrUShVsKdQDcYu8vOCY8jN+h3QDwdEh4x0=;
	b=i7ISaPaCWxVbGuEgMkA6B+T7fADVFy8+GN//dSPQwI+QyNxqrNb3cggFncJkUxEKqBNr
	 zJWM/ztApfVCsz1HgNzH8KCg6BM7jGNZPtr2iITYyPnBnMD8g1ZDEB8bO4lTAE6mYz8J5
	 /9QCXmP2m2iaNigS31P0wfBhlUkS434+KeEQ7drcBZGRqdvHheC4/hBPFYKhyD44qT3Zi
	 l+4MnANu4Ef8IH0ttvpd/g5cLm9ONHu5zSY8FT2c1WE7cbZuYK5z0IvqZXSvb1O61m2qO
	 4NBvNQkp2+hFWZtx6dFG25aaSd5BspYxXOMFDcK/mvWvYboUvu2huffDjV7CFr0POWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7OdNw8u;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA0606A338
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 00:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCA0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7OdNw8u
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so20394995e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 16:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307721; x=1795912521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjaMl1GYSNrUShVsKdQDcYu8vOCY8jN+h3QDwdEh4x0=;
        b=G7OdNw8ubMfnu0UlmljrLYczxmam37Hvlt7nwb3a7fIYbFNVpqqckCTvlyUy1f4gwX
         63fw7LL0vzy3rhl29hr2xbMTePxVpQvdpxLddNixhyBNaxZ45M/43wRuyMv/1gdQgFCy
         ylAMaoojgKS69rcL33985uN2DvVtg3Xsf/hOI+B7tNZyJL3Mq0WlmBWQV2R87SbI0NKo
         jg17r3X9bdBEPbNxBUheGepbPqBX8ql0Kcfa74PbzAVoEBOpxgXSDTdXx2sk/m27assf
         jICviUjUsNVIg8krFyn90l/h5CgnJnRl3QcZOZIZQnzCIEEwuff/PMsKrATRzfZqC/+t
         YtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307721; x=1795912521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjaMl1GYSNrUShVsKdQDcYu8vOCY8jN+h3QDwdEh4x0=;
        b=Gc+hrqHfooBZvU7oN01ymJ4NuWsJmGdIis+cqKSm+SSrh/5WnHEWgZ0YkDCCdfigqm
         UKgE8IvhQuEQ/zEdf+fts+HmgRqGkHmpMyMZOyMF99T18afMAilmpq7sKXwX16u/GW6N
         dOkhabi+vyZT1x8raV6FzjMIeg1rD7jyiOHFhMpnYtn/72uRz53O3ceIL3fOeqvdKNSB
         loyi+SPTsJnodmy5bOhRInOv770nxyupvZjOsVXZrpam0/2aU1GW8z20CUJ/y7OTFRJh
         gNB58zxw7+YsLL1SROKoQeL9qSxu7EfyO5n3ZciilOfpKrC5I6/tSQUN7dSItyQxlJ6W
         5QPQ==
X-Forwarded-Encrypted: i=1; AL+hErHK6LazRzVWY4cZKGgn9L9JG+N4Ubbbwu/qJpYY/fdu3ILzJcnFxdZFmEbgL71BQDmlCaqaI+CcvQ96pgtnLzlsx/I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/C/O9uHSngvVv6fx+MM/8xqo7wHYwVaxWe9ahmuRjSvzwQEaQw
	aVgUG3St+jggAjLN91AK3Fh9vRagwjXpVZ6q+KgKGu1WtwlcYQdXN6r/
X-Gm-Gg: AZFdTZezqOJNgh15/PRbSKenuuGBHo7Q2BT6EgHbdfZ3irCEPfwfNmDDZmmoNvWOITz
	0jTASRbLOSPQZ1a151DApa7ZeGXgxjhRSG8gV5Jv+HPu1j+4ufvQGGGz7nNOVpPiOIcGOlHybXe
	h7NuoMfQY+dUW0ILxTfjci+Sjdpe0zP8p0oUZti38wP06/SFji9qZA9gj/SgU9TPlTdHYHATGbv
	nsXx5C7YkBDDj4vYTq1oc34aKLcIInZvHY8ek1Qm1mJTUpdAoGVTbYyFrxJt8B4k1HKWFirDAx+
	XFKpknlHkqHBMXRKJDz3XkjWsRmzZjNxA7LnXmUR85GncOKpoVnG43izdzUVVjZAl07eOpDfC8+
	sJ08Wd9OQMln0xiyyrLD6S6RubqAiBzs1fD8gwOBvdvbpUnAUK75AGED1EiuYvdg+gzKhRz3LTA
	AvPsi8NIVjEq7BMXfC/H+OuHggm5hzldGnHFTWSlezwcpaE1LLDLmBq+QNSktggZVl8oyDhLU6H
	p5RCPhjQwr1xy/Mj09clhYrubnER9zy5x6a0m9vKP0a2R5/nmxV6S7OtedLIDLgbR9aZeagXNIY
	MAvzaazUFrlhgtjObihQglldm7NROm4zn5+Zm0oZt7EXlXKYfkWI8I8E8h5DxcQOE5U0u/mnpOH
	lCaOMo25UzG2BdNYN48azW9LaQiLvmSqSUdMHg2vOmKOS+Jn+/1YhK6OcdzDjsNHD9lZ0lQDsqD
	7vM//npIDXLOxOkoe1h0jdKnJLI9T3m/FMkc8NpxSi+3hV5eg+QWFqp4LSJmuobjmsm3wVHOc2N
	4ygzCUx++qalVhyNg==
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id 5b1f17b1804b1-4bb88817d91mr170289725e9.23.1795307721109;
        Sat, 21 Nov 2026 16:35:21 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-2025-a95f-1d53-595d.rev.sfr.net. [2a02:8434:fda5:4201:2025:a95f:1d53:595d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm74017825e9.5.2026.11.21.16.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:35:20 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tools/bootconfig: Preserve tracing settings across export and replay
Date: Sun, 22 Nov 2026 01:34:57 +0100
Message-ID: <cover.1795307698.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks for reviewing the earlier bootconfig fixes. I found two more cases
where a tracefs export loses a setting when you use it again. The graph
depth is exported under a name the kernel doesn't recognize at boot, and
an all-f CPU mask is left out entirely.

I checked the rendered kernel command line and exercised export and replay
on my Ubuntu machine using a tracefs fixture. The series is based on
bootconfig/core, including the earlier CPU mask quoting fix.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (2):
  tools/bootconfig: Use the registered global tracing parameter names
  tools/bootconfig: Preserve all-f tracing CPU masks on export

 Documentation/trace/boottime-trace.rst   |  8 ++++----
 tools/bootconfig/scripts/bconf2ftrace.sh | 21 ++++++++++++++++-----
 tools/bootconfig/scripts/ftrace2bconf.sh |  9 ++++-----
 3 files changed, 24 insertions(+), 14 deletions(-)


base-commit: 0ad31c3252d4c626a93ae6251340ef86b18342d0
-- 
2.53.0

