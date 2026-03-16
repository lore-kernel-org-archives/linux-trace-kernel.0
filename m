Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF22241139
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659054; cv=none; b=OsNExYPxS6v6p2YT7pOfPEgo0B2C9zIDeX+LPIaKESb5jW+NiycI0BXiOqmbGTzzzFIa3jbdVgEgQRUQbFCid37I77fBWawPqEuliguFTo9zbKthRGGEoXkDylGDy3DqKWKqwst6kF40zc+EfakyqIkUXJ6ASsStFGtNMgfAOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659054; c=relaxed/simple;
	bh=1Z2K5uAxzV9s8L4/BC8KNuwonWVfjkCKvcQHutx8mBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5H/dUiqG8MQk41Yn8KlVL4qw2hMu/og+jCAhI/fDGfoHgNGwWx/OmKyRThSsYWMk2nwg7ASDpAQFJfGzsSt+qcaJHHUgI1YIzVUwNDKSCYbTFUoOZVag3A/nCYYcfZw3nWOQ2ZsYEKGCfKkvDbyouolALB8Sr18qJZLoUac138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICET6ahO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICET6ahO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
	b=ICET6ahOcEmeSuifDilNtqfn6IujVNVMITSg+N695hw1weOf/TEE9NR+TROs2JM8Cu8WyD
	4RvKYifVMRb3P80EWCBsRXMRegfvwx5SWgy2H3jwY828vKQ//la3PmWgJus+I2rSKa5ziO
	WH5BvuHC4Pb1QQ9XdxyWwIG0tawGIVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-7iyH6IXrOUqDlI0gKiSs0Q-1; Mon, 16 Mar 2026 07:04:10 -0400
X-MC-Unique: 7iyH6IXrOUqDlI0gKiSs0Q-1
X-Mimecast-MFC-AGG-ID: 7iyH6IXrOUqDlI0gKiSs0Q_1773659049
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b3a41c62bso1449584f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 04:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659049; x=1774263849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
        b=TRyrRCO0RgeJRu715AUFmqND0RQzCsJdGDoq1VXnooALxgOPWxJT8K5siE3K86uVFF
         IlSxllHMCZy5bejUblWTCZSuTycFEP4SKQDuSp15h47gO1VdNZ9PnXZ7Ja68wdnK1wa0
         eQU9osUyVY2gMT+hlSwEtKA5pA21YEzXZwUDVsNlp+bVMzBJRFZZuaU3chPeHP8ShJXO
         k0wPKS08IDBMMBmuMVRgjWbbJyt14MUY3VsNkyN9LdlgeZS18gupdaftL62eJpDnh6MO
         chmaD2HSyYn8wDFWC3BJl3PfFZspcTv+8ij+WAgm/U7gj+7wwvUb/pk8NGONh0PYje3g
         7qEA==
X-Forwarded-Encrypted: i=1; AJvYcCW7SkY9o+n1MTUk+xFfbcoiPbZ9TevADUWYTR3MOIKOyoq7cae2bjYQDc0tFIydb8JYAnX7/1amn35Riqjo8yKvakU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1O8WrHfltMVOQht7tLX9tortUAtC+fsqbwA97ewgzU2mIh+0W
	3eramSG+ffEqmQLbU+INVkBcFyMeIkDFpq1M40nexto6o0lhJyzcsAU1btNplFOUrIe03ObJ/11
	1SG/6xNbRSDkQGznEEDMTpCZwE1evUY8pXQ66CzYKN3KctgPK6+KIsiQ0qtk2obS0vJ6oM6r7/w
	==
X-Gm-Gg: ATEYQzzj0xS7Jeoz1EuwLrmji3ac6FrcY2IFSx9/y6GvF/3BCb0jgPYMYyJdcD0K4NN
	ls9srxgGHf64URNOyMVKSkdBx74nJfPxw0wQ2aae7bXWKIlltUdjuPSWG0ayDNy1Uznyi+eV9C8
	wnDOe3fnq2Z28OL53N267NdaVbExqMriisMY7+75+PCsAK5WwtOJw8vPD95JlJCpV4vi8TwyOus
	xsA9A6WQl0ReT01k7PyhwEnpgynabsfdNavzxQB1T9iGBuSBUgKuUp6+RwaoFC1Wefj9oTvCH3A
	PzZsuiuJR24526P0DDaiDFQv/If+RxXOZb/Td1SFKi1lSpVxmB6PgUVfAQz1ehT+u60clEHgCxY
	LKPDgaJu+zpVR7ur18qBEGbFYpYsowUsOZeZzRg6JWeY77zVg+n+E1UE=
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339354f8f.14.1773659049149;
        Mon, 16 Mar 2026 04:04:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339273f8f.14.1773659048589;
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm41595197f8f.4.2026.03.16.04.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Message-ID: <442cfa35-78b1-48f4-9565-e884e7e60d79@redhat.com>
Date: Mon, 16 Mar 2026 12:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ADj3vIFAosw6rY7ZZIQXqVZaQ_9uR2QS7Wxp80WCBJA_1773659049
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
> more sender-visible window than the current hard receive-memory backing
> can cover.
> 
> The new helper keeps backlog and memory-pressure limits in the same
> units as the rest of the receive path, while __tcp_select_window()
> backs any rounding slack before advertising it.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  include/net/tcp.h     | 12 ++++++++++++
>  net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_output.c | 15 +++++++++++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index fc22ab6b80d5..5b479ad44f89 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> @@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
>  	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
>  }
>  
> +/* Passive children clone the listener's sk_socket until accept() grafts
> + * their own struct socket, so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);
> +
> +	return sock && READ_ONCE(sock->sk) == sk;

This is executed under the sk socket lock, ONCE annotation not needed.

> +}
> +
>  /* Note: caller must be prepared to deal with negative returns */
>  static inline int tcp_space(const struct sock *sk)
>  {
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 352f814a4ff6..32256519a085 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
>  				    (u32)TCP_INIT_CWND * tp->advmss);
>  }
>  
> +/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
> + * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
> + * already consumed by sk_backlog.len.
> + */
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
> +{
> +	struct net *net = sock_net(sk);
> +	int backlog;
> +	int rmem2;
> +	int target;
> +
> +	needed = max(needed, 0);
> +	backlog = READ_ONCE(sk->sk_backlog.len);
> +	target = tcp_rmem_used(sk) + backlog + needed;
> +
> +	if (target <= READ_ONCE(sk->sk_rcvbuf))
> +		return true;
> +
> +	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
> +	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
> +	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
> +	    tcp_under_memory_pressure(sk) ||
> +	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
> +		return false;
> +
> +	WRITE_ONCE(sk->sk_rcvbuf,
> +		   min_t(int, rmem2,
> +			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
> +
> +	return target <= READ_ONCE(sk->sk_rcvbuf);

Same here, and more cases below.

/P

