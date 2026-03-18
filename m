Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495903D8134
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841272; cv=pass; b=g84G590+lGFqUkhDOvBVx+gUffWxjubtyXF0MFsva0BsNmK8GcyVfR7RVgGG0BbQp4qPOJ8FlDFmvP5HfFTeOJeZ93q/CiY1Xzo7p0Z9U4ZyJF8EoO3dJ+55JtJPoN7SvKhI6C+uy6R9S2C5+jlc4jc9QzU41dPXkPbFejdIQys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841272; c=relaxed/simple;
	bh=z/euYNrr2+BYwM4a/WfQWCBjyGxEkyKa2+Erlae4Q9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8MKzKCRfR1mp4Z/V5MYN800Ws+3IqVNDuNGPSFcIjETXqYWDBCgYopxSU8mHNPn1i0LvBY0aySAMNYyEgK1ZbLSb3zs6z+I2E9FUt6JZkWmOFx8LOFuAEPTTMDS4l5uq2wSAB2Affkf+MhWQPA2uKDZpnVU+ga5e3tJhkv/g7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=dHR7qY+s; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="dHR7qY+s"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64e8cdafeffso1415320d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773841270; cv=none;
        d=google.com; s=arc-20240605;
        b=f8D1vkBewhRzMDPKgqqqSHhUWXhnDDQ317JqQm7x9w6O+e75PbPeyvz8rSywPaiYya
         ZyNqyKxHteXALVsSWizm0u6mDphTnDvo9d0ADFx1VAZSEiv8T7vL7YyIS3Fiy9kngTO7
         SezB7RZCvG48M552CoTXSLLsuCzqh/rIhfBlf6SjXPd6RCgfA/QJYu9tAfxaBOd+A++K
         qxpMAyXG2psKZ0CY8UQI2thCTPR6eLaVvf2nazfR/INbs6PdLpQIxlj++NCZQd9QJyGg
         6Vl4L3YmvBAExaAG6lFR3fveSWLyy4tM9yAHlAnEOoM9CRu8OGCI6EOacBQiGq6CL780
         amiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        fh=xxbA2otFvcuiyxoidiWn19kxTENnXb2a8pRaII5W7uY=;
        b=RG/kn6FRrDAn4cE1ClwMT4frMXJyKViR4prHIbJKCEU76oZ2R2j9SPImLmyeyPBL8S
         x2s6mhgtvnm9ZTGGfCfX/4WP9oaB7FWpi24izG2B5KBVQXhuIGRQlL06uUmsi9oWeox5
         zUtQBG6Gmg70LDx0be55HOfzIj9edr/5lgyhFAUUKSgrbgZvreata794QUc31nGFUOjk
         A+Tg/8FncF6JWqhZixaaUSJhqHTFhL9lOwRveZM4COiRp20Mx66RZymTGsmDa0XC4l/l
         I4MvJ6NFxw6JydeMx4AnB3tt7mv8IWvE0s5oddaXWh20m1ydsUm/abA7Zs95n/2pmn2L
         td6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773841270; x=1774446070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=dHR7qY+sinjlf6f57N5bwU+OWVeO6VT/zMk8d5oKM2o0C3T8Sp3ZXtAZnObYRPtEuS
         WxeTpi4go96TnLWYkgmt0aOjP12Oom65Mqlj/ZXyeCiWwe9nUNYh0kjb1prG23oA2epx
         cn30OSbs08MsHXAF/CUKjs3yT+zkspQGYoKWXJNWn66iOVv2wPMZyxzLIcioiugwFxfg
         32vsERmsQU2CI9vR7x93m/U0LoXOJ4GmUg+0O2CF8uPdju5yiY98JkPblnudsOWA9czF
         fuHnXYn3/+TjbO+xnvUORLjB26mHpUBRG5VZnCpy91sjI0TevBprEamvrGjxg0V5lh6g
         zI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841270; x=1774446070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=mwtgm0pSsc/4wXVWpEWuQZ8CPtaz4dkmz9lvQzrJdgGPWdhgVzGM+Is0mL/enP4zV6
         1lpOx1oqbwRUWOZHqTAG3JQP9c+jRwvpcx69iFoOxIBY8tMNEGu4nPpZ5AsXoI0z3JTp
         L0uFqgWuvK6io7PfyQQmjY+wkr3wG8WfBoW0L2jWQp9566+Z9Z41N7lvnF1HvytfXrXd
         UN8q3jKdoyZyM5x2MbZtYa24Of1cF6C3zDzuyg+cEt4jkcl6XKoEGdG3PT8stZtq/Ozz
         lp/oPqIEo6mHTD8CPjnFQvN54If8sx+pvTNvj/KPih+MAl9ES9M5rHHeSMTeUNnLJTSF
         H88Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEuFJIeK4aeHVlrUa/zdTCpfsuq1vGZLTe8Tyd/LSuf3RQFDHMDpig4pov2j6vPcqVWo2qX5JVGdXLxbsMNxWMLuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRcmeSlvxX14ZEpSXiv8aaxBofkzP5dXaZdytuNEwl9nfEqPX
	8EHyoX8yBUBrQ7Ysfgv6B+U1i+jX+fm37N+6Ee3uVY1S440XWazBw/u7epnKTjZ37DmsASW9WGx
	Iyv6J/4nVxNkD0glflYNeZ5cgdVd2gqPVaqC2+8TvNw==
X-Gm-Gg: ATEYQzwEUqOqYC/oK8vuXVPPn9wIcZXj3+ddwKYlpJ3vOmEv8BfsvJ+9ZDVULto6EQy
	x3azVKNPV3IRcLN9SqmXsKNPzdvbvwIo2ckqM+n3KS4seDrILHYl6aOLdOf/mBCQqUF6N03MWoB
	e9VsQB7QZi+N3XfoAqc+zYjTaW37epXazLb4sLvJ68f7EFmocntfms8C3y4I98YjtX4qMQB0Ks0
	Hy2WCZxW35MhMBnEjZACczjbV2CkDZV6/JOU+L0juoDjsW42jKITDlZhI3ygp/OvEIJOimaAfic
	9YpbbbuityhjppLKMA==
X-Received: by 2002:a05:690e:419b:b0:649:b234:3905 with SMTP id
 956f58d0204a3-64e88b4f88fmr5765244d50.41.1773841270022; Wed, 18 Mar 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
In-Reply-To: <f7to6ktnjxi.fsf@redhat.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 09:40:58 -0400
X-Gm-Features: AaiRm51CXqWYj3bhPG1VWTfExv82dHZMJIVk-_egP6VLHUZcmabQcnoPToaB-4M
Message-ID: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: Aaron Conole <aconole@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com> =
wrote:
>
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
>
> > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_invoke_foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > ---
> >  net/core/dev.c             | 2 +-
> >  net/core/xdp.c             | 2 +-
> >  net/openvswitch/actions.c  | 2 +-
> >  net/openvswitch/datapath.c | 2 +-
> >  net/sctp/outqueue.c        | 2 +-
> >  net/tipc/node.c            | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 14a83f2035b93..a48fae2bbf57e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *hea=
d)
> >               return;
> >       if (trace_netif_receive_skb_list_entry_enabled()) {
> >               list_for_each_entry(skb, head, list)
> > -                     trace_netif_receive_skb_list_entry(skb);
> > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> >       }
> >       netif_receive_skb_list_internal(head);
> >       trace_netif_receive_skb_list_exit(0);
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba7..53acc887c3434 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info =
*xdp_rxq,
> >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> >
> >       if (trace_mem_connect_enabled() && xdp_alloc)
> > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> >       return 0;
> >  }
> >
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 792ca44a461da..420eb19322e85 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp=
, struct sk_buff *skb,
> >               int err =3D 0;
> >
> >               if (trace_ovs_do_execute_action_enabled())
> > -                     trace_ovs_do_execute_action(dp, skb, key, a, rem)=
;
> > +                     trace_invoke_ovs_do_execute_action(dp, skb, key, =
a, rem);
>
> Maybe we should just remove the guard here instead of calling the
> invoke.  That seems better to me.  It wouldn't need to belong to this
> series.
>
> >               /* Actions that rightfully have to consume the skb should=
 do it
> >                * and return directly.
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index e209099218b41..02451629e888e 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_bu=
ff *skb,
> >       int err;
> >
> >       if (trace_ovs_dp_upcall_enabled())
> > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
>
> Same as above.  Seems OVS tracepoints are the only ones that include
> the guard without any real reason.
>

Makes sense. Its simple enough that I think I will include it as a
separate patch in v2 and remove these changes from this patch. Thanks
for pointing it out.

Thanks,
Vineeth
