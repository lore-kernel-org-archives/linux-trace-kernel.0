Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDA2D8DA6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745327; cv=none; b=ejzoZ/QYQ9ZYbcZ8rpf/cbVVVjOx/nLo3BQKkbD8g6xlbtwL3RQOQLYJVKViD/8X22u2vJVEjmsAV7OVzfAcXhmJTtx7e9qSSkBzrcNKIej2NYd23brIlNgOMGeW1vSjlsrtNO9NqyjGSegnjw/l6i9eVbvLd525cN9Fv7FWh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745327; c=relaxed/simple;
	bh=zbMOoAZx7RYNx6TmQte8UME/DXY5NFfuty2hcf87lug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKai3q3vpAnLGNGmiOS4jH2NhOgTM1axqa52EBFTmooOSol9Wlg/Co4zTYXpfzp7fRYKbAtWKJ7jMJUHhQSdcjFiGEi4+KP1wqgIWylaKwIWG/wpnmLvGXBA8i4OokfgHbsFjjiOnPGyqcVfzTLncJSdLbXFQ0HNx0CZ6bEwa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK0rm6No; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK0rm6No"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eccff716f4so349351cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745324; x=1762350124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=YK0rm6No9KRbzuf/URWqKnByLSVQRYT2bE9JhVyRFfQsg3/c1kQwOfw16OsR5C5Rzt
         0FUM9oz5FYLvNjs/0z9hbh/wzNlx3pgVhQyDD305Nr83w0uAneWHAG5eBfNy4PlL4TYo
         M88hIKNbQ7htu1BrRLF0hbyLkQM/upYNZXsRnC8UuI/ZgoIlHZb7JZbcod98HW1x6i6i
         GyV3k1bGV1jyPUOcE5V3o6jdNsT3lqRYur3nZj9j5VSIN9E4baG5bAg4XQ10qsjXsZv4
         mK9OFme9K7P/8eB5+qvn5u6UzzZ2X3jO0icWBNLd/DhCcgBxAyDGyb9PinWDf5fLYNZJ
         36vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745324; x=1762350124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=vpfrskh15YRwRIYf+mfAggyHAd6Zeq6LBmgp0YCVFC3HsQ/1wh/m99MvItXO4kHM+M
         uueoy9fC25Fn5RZROIfoiaszolM02GOidVFJpPqx40SiRyniVTlimdpun+GAZz59qDX+
         7N/HKsuY/dIQerkf3gwEEOO7TN2V4n1JlO1JpA/3E/pJqG8VCnqpGmKTK2N3ZoHnqE2U
         dpjowc1pudwpcIY1lOtDjCv460hwb1Mm+e7HcKj+VHpaBP6G+VpvJh1g8l5z92X0//E0
         O14Z4gIXKuZIEQFp57inIyp36zkgYvWvuC1UpU+HjWo5KjLATAfNg9GOmcQqq/5KSI4Q
         Vuqw==
X-Forwarded-Encrypted: i=1; AJvYcCXHAyzIsWl/ovVRlMzVSDoiPtwAz2i1Q0Xo5eiUE7X2lmBC78s6t/N5JslMYaAetOgwlxXcpV1afYcfm+bIGLQJIbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RJ594EX9fN9khIoLs+ggtv2WLhkFZLb9kVWhYE4i+9vvauHJ
	ddtD22ezf8hRSa2+cwG635W8aTO1h/4AqtI3S8+0A9T4fi6W7LtNEnP9a5TXK8FRLPckh6tLSmm
	CYsqhU/uyDpVLKDHxQq71QtmsThZ63CR2rIkNh43H
X-Gm-Gg: ASbGncugnOA9QuGIkH7jE5dAYAn6oHKjC43WpX+8h5lWcLlJ1QnXBtaN3tdJ5lMj7H2
	OEPrnJvTlMWeK2X0sNQQ+5INaKUwQgNIRozA6GeThP8b5/GcbxdNFNOHbHfODG9Er43NhcBbamh
	3CA+px2gutg7KK/F7PM1QiFnS3OU6FQRN2RRfFs/pFEzRZ7PLbZsZ8qK3fJKKsloYPIRYRJTx4s
	6FW8I1DDMoG6DmRF4zyzZ9olfUoc6u2+R6uXWp4bwAaZ7KXv+UGLcdZo1eztdZ07nrhrOYoyXd3
	z7p0ICA1rLMSVeGA/vsvm8fhr5fwk9PemSFylCIDDTnCmvT0oQ==
X-Google-Smtp-Source: AGHT+IGOZDQAj/TycBpf1oLko6kxdZqBO2Sk3hT4y5SfEx6uw5mwTcmg8Z7NahmZfp18PPYf1PTqZO5h2SskSugGe9E=
X-Received: by 2002:a05:622a:5a97:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4ed157cfd4cmr6757411cf.2.1761745324169; Wed, 29 Oct 2025
 06:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:41:47 -0400
X-Gm-Features: AWmQ_bkzo-mReBBs6WU6490vxEeqlXsoSqmYJljmFEdRABTFs0x5o3xtvuTei8g
Message-ID: <CADVnQy=NBw3RL+yS4=4AusooKkiMx9Wr+20dj-14fK+jPNw8pw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> While chasing yet another receive autotuning bug,
> I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.
>
> tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=3D50307 rt=
t_us=3D50179 copied=3D77824 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=3D11=
0592
> tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=3D50336 rt=
t_us=3D50206 copied=3D110592 inq=3D0 space=3D77824 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D509444 rcv_ssthresh=3D328658 window_clamp=3D435813 rcv_wnd=3D3=
31776
> tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=3D50305 rt=
t_us=3D50070 copied=3D270336 inq=3D0 space=3D110592 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D509444 rcv_ssthresh=3D431159 window_clamp=3D435813 rcv_wnd=
=3D434176
> tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=3D50313 rt=
t_us=3D50118 copied=3D434176 inq=3D0 space=3D270336 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D1299511 window_clamp=3D2102611 rcv_w=
nd=3D1302528
> tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=3D50318 rt=
t_us=3D50041 copied=3D1019904 inq=3D0 space=3D434176 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D2087445 window_clamp=3D2102611 rcv_w=
nd=3D2088960
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal
