Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493555;
	b=a1e3p+mTNK+xLgvN3denU+a+8eaXxs9B6VEHjNAq3skCE2C7gnRDfrwLiccZEUA45QO2
	 bmWoI8tdSLAxnHwIqSTEWIY6YoPAcq63YKxJOBZahxtGneQjgCnUX5sXABvr5TcBjjrX5
	 xg7VAC38qcILTNqfMMtwHMop4xaKVdau/90JQxvzDKyVSrPxMgHQCvxmvLokU4vyyPXbA
	 7yzldNqT9zgjCvcgZwzJq+91pCRBtPBzfsZgVq6UVne8MUw+BV8MYSNGdjR/xnEWw89h6
	 HWreejpjNiDvdG18JCOzjvDH6WKbtPXwg24o4T5btvI+PH677TduIHDkZ4/f6vVnieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qC9ssOMm2iP6KgLcDa1jRKWVaO8OXpMM2x5cERwms9M=;
	b=2YcfVrxOFXMgpq9BPh4ZAjmgCNH3lOmWsw1tXLRuXm21fQb/PAJ29UeVXwokC9XhFxWK
	 EzP9sW1Q3l19BnzpS9eZruRskd/KRbcWBl9t53ErEclHeIVCOB928DSOE7+txQ4UnB3Em
	 9h5g73u/rdKXZ2YYh1HS564LYCfxnu2GfW5Gt7qzTU8DV/yoF/eq/rmMVCnF6hVZnz5LU
	 3q9+UqzM5xGQuy7WFzOdgKgSZCtclobyezIDUvBZAvZGebTI1/mbfpMmqYvpPYOno/biZ
	 lt8BPtzWdclrBzfCaE5ybxs9D6MpIaOU9tsygiPC2oEAsR6RUeslNryY2HHMLS/I8Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAIuE6rB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4260703A1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAIuE6rB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B9C1F00A05;
	Thu, 12 Nov 2026 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493555;
	bh=qC9ssOMm2iP6KgLcDa1jRKWVaO8OXpMM2x5cERwms9M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KAIuE6rBLyiotoTs8bs3XT4vgI0F5HfciydgbysCNm1ZdXFP2aTHCTxGlXqCLrHV4
	 0DtPYuxt+6f8GQEn7HBi0LWrXeYiZiUscZVoT5qhR04Z1nOEaCg8qCP3Zge8zJPgKj
	 cLDzE/rLohtBJLh0b3gG8YLSr9pf/GTMrQUgDkpDHWfkezBnpu6Qrbof6hnXh2eGaN
	 dxnDtA5EQYAQTHzbSQ1k1g0ITv5QacpL0faXM9Ohu3d0ILhkNSzgmY5WHMfDIj3Jn1
	 HGDpWqa8Ot8qRzkCyXnTHk/EbAym5TLS3DqIeQkZKGnk8jndDWHJJ4y79dWikwovBY
	 CbWNCXzYSpJyg==
Message-ID: <sashiko-outbox-211313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/9] tracing: Cache ring_buffer_max_event_size() for
 trace_marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261112141440.3050124-5-vdonnefort@google.com>
References: <20261112141440.3050124-1-vdonnefort@google.com>
 <20261112141440.3050124-5-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:25:54 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing: inaccurate Fixes trailer in write_marker_to_buffer()
  commit
--

commit fc0aa729f88ae3461e4964c8c56c6c6eee40f687
Author: Vincent Donnefort <vdonnefort@google.com>

> tracing: Cache ring_buffer_max_event_size() for trace_marker
>
> write_marker_to_buffer() calls ring_buffer_max_event_size() twice
> without synchronisation against ring_buffer_subbuf_order_set(). If
> subbuf_order grows between the two calls, cnt may expand past
> TRACE_MARKER_MAX_SIZE. Read the maximum event size once so cnt can only
> shrink, and drop the now-unreachable WARN_ON_ONCE().
>
> Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace su=
b buffer size")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

[Severity: Low]
In 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub
buffer size"), ring_buffer_max_event_size() still read
buffer->max_data_size, which was initialized once at buffer allocation
and not updated by ring_buffer_subbuf_order_set().  It only started
computing the size dynamically from buffer->subbuf_order in 472ac478b14d
("ring-buffer: Dynamically calculate max_data_size").  Should the Fixes:
tag be:

  Fixes: 472ac478b14d ("ring-buffer: Dynamically calculate max_data_size")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141440.3050=
124-1-vdonnefort@google.com?part=3D4
