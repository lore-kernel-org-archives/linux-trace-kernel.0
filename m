Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96F472072
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194691; cv=none; b=P93sqdoaOGq34rvY45en6F2ruKUXHJ0D1oFwaoJnTzsfibsij4rZa2aOjRNhzTQgUZnMI1kKWPrXQiuEW9KVL/sO8rzAy8jUak4e84P9MWLjud5nwzL7CSNbeKqBVR/Z1VSgQzPaQZQYk1VvHUl5pJ+rekxvlrcKaXQjrZmahuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194691; c=relaxed/simple;
	bh=PmYaT0zZh5OYZT8BBZqIL+F0mR+bv6a4Ebmxc1vaLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuZO+3QOOBL048beD9SVGf7YC17tJu8liIrOG3vtHQSBI1LpDATpIeoDnLdjxEqo9LomDYSKw0b3Ch3vsd1ldqF1LW9U0i2VxniZH+BYzmTPDK0eYUnylg6oPVSUZyu8tpQ5PEYFdhRMJBLwKli8DCGSvQQUA15KIJEL+DLY9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6RUCrV+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6RUCrV+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee846deecso1142818a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Oct 2026 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194685; x=1791799485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndTgZQw5uRGHNOH8AqWMxH2rBGXg/PpSxnD0ym+93as=;
        b=R6RUCrV+xUlPIWNGizz7Nh58t0D+aK1g0N47YcdCpB2YtiWxxuJawYp2fB7SJh2owB
         QZ2LcwSdSsjxQyFD3wN0uL0iNKbZZx2AU9nfCXwiOvyoHU8N1vY4C4ctcw3vuq4aedaW
         +PHstUuQ8tR4pFYMsGnPCRHSJFlr9Yh13rYUURM3r6O+JxE7zoeFckIm7DF5ZS7vT/Qm
         CVN/OsRFFmPw/3Qlta62zUAoqL60mho3LKLSVyTFhH7kT7goKbm+SnVfcFNqG3CA4P7H
         +8bNbB9BTGS/dMAzkFwglUpzjNRj0jB5WrHCKMypRXoRgL5GD9JbUx/oOQe2xg2a20hj
         bcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194685; x=1791799485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndTgZQw5uRGHNOH8AqWMxH2rBGXg/PpSxnD0ym+93as=;
        b=WPLqKQWTURbwZDLhS90s7U0YlnlwV0w2qjv/qNkEDNaMyxsMwPFr1dt2jTDTZlFPSV
         H9YnkKE/lbDWP/lz2umAHvaZE5+4beVSOyoDCK6+tcLmJ1OdVQD9nH43B5C2Q/7cY8g3
         4LUYAZ347WKRHdVpUmFTgdTKJjhXp5PWcMw0ub3rUCYwUeCWr9ZqUUIPePr1bvaLeIzr
         ZC5WFycOq86lShIlYg+qw5NfzB/ApMPIcVOIGuOAkSd+oWTcTRpXKuhHw5SOIqQGmVB8
         saSJwjOxY/NOM0g5jSu7GYNxSykY+DowA8t9q9zhGLX3lrB2ase8rrLvNT7vA7VOf9lV
         klig==
X-Forwarded-Encrypted: i=1; AKwUvBxVXOzJi+elzpbskccyt1ZF3ZCnf5r7goFn9Vu1Y5BjnA4ElnSF438kQ1XyaTW4yZn4b5X9FjjM2IqJoVgVBP9BEOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTyPy1Y+xpPM93PDDJlAAPqF6deM2l43SJHmGj+aEpeagUhZ8R
	fzHaH8GEbMuQeZKmALRE3VDg4lT22V44Y7eud7t2ZBFrRe4Sem+6w/Il
X-Gm-Gg: AYBFou1Q93wGgC7VmrYPTa7BINkCA5L3q2ISfveEJcyIu0JhyZgYiFLKSTnQhtSPnxH
	IJF3vmbayhAV56LxAHCUrM5Trc6ub2kQdYB8noTwXbxI8zboQ8DHgeGK7OWz6nYZMDp4FE5/WTr
	LQdTiLWkLp+Nsb1r097oPqrQsQ9RCsZjhh1+EMCoLs9MxPnejjfNy1dym+M1bff32hICP0Wxpkx
	dsx8G51eM/vTkCq1dEfyoQiqnPAJ5DivgoigHTs57zozoR9+KFOAQ6P4/v+2YFXDdAD8p7GGPKH
	bNvB2JsnfiqjjaR+w01xap5ScI7xKkspiajWRW/ARYLGP7rlW9Qzs0sKJec1K2qd74lPlcg8Dgk
	Dg4/xYJysWYAk9QW2MWz/G9cpEwlyQiWE4KDAKEfazJ2Tr3OZTN/k8tdnslJcA6RFMILqtDF/Kf
	SBqchxmLTY47PQPUQc2pt1Hc1dGTitn6V9XGbCPlYx/fGzPvY9GQlWgY8VftoNrNwyfP9LCHEnj
	IR2r8urUzrtmdBd6hZ78g==
X-Received: by 2002:a17:90b:2752:b0:3a4:b0b9:6b3e with SMTP id 98e67ed59e1d1-3a7873d9565mr5545486a91.36.1791194684453;
        Mon, 05 Oct 2026 03:04:44 -0700 (PDT)
Received: from gmail.com ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4cd01asm10487467a91.14.2026.10.05.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:04:44 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Mon,  5 Oct 2026 18:04:29 +0800
Message-ID: <20261005100435.1211485-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003202727.3673-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Ravi,

I agree with SJ that this would be more useful as a general quota-goal
tracepoint rather than being specific to NODE_ELIGIBLE_MEM_BP. The
target_value and current_value fields are not metric-specific.

On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> evaluation.  The tracepoint fires once per quota-score computation when
> the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> context_idx, scheme_idx, nid, target_value, and current_value.
> current_value is reported as the quota tuning sees it, after the goal's
> complement setting is applied.
> 
> The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> occupancy as basis points of eligible bytes.  This information is not
> exposed through any existing external interface (perf stat, /proc, or
> sysfs), so the tracepoint is the only way for userspace to observe the
> target and current eligible-memory basis point values at quota-scoring
> time.
> 
> Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> ---
>  include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
>  mm/damon/core.c              | 16 ++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 8851727ae162..2c7249cc7c88 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
>  			__entry->esz)
>  );
>  
> +/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */

The comment says "Per-tick", but the event is emitted for each matching
goal in damos_quota_score(). "Per quota-goal evaluation" would be more
precise.

> +TRACE_EVENT(damos_node_eligible_mem_bp,
> +
> +	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> +		int nid,
> +		unsigned long target_value, unsigned long current_value),
> +
> +	TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, context_idx)
> +		__field(unsigned int, scheme_idx)
> +		__field(int, nid)
> +		__field(unsigned long, target_value)
> +		__field(unsigned long, current_value)

Also, context_idx is currently always 0 here, since
damos_quota_score() only has struct damon_ctx * and no context index.
If this tracepoint is generalized, it may be worth considering how the
context/scheme are identified rather than introducing another tracepoint 
field that is currently always 0.

Thanks,
Kunwu

> +	),
> +
> +	TP_fast_assign(
> +		__entry->context_idx = context_idx;
> +		__entry->scheme_idx = scheme_idx;
> +		__entry->nid = nid;
> +		__entry->target_value = target_value;
> +		__entry->current_value = current_value;
> +	),
> +
> +	TP_printk("ctx_idx=%u scheme_idx=%u nid=%d target_value=%lu current_value=%lu",
> +			__entry->context_idx, __entry->scheme_idx,
> +			__entry->nid,
> +			__entry->target_value, __entry->current_value)
> +);
> +
>  TRACE_EVENT_CONDITION(damos_before_apply,
>  
>  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b63e60ef8990..6ddd15dc4f55 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
>  		highest_score = max(highest_score,
>  				mult_frac(goal->current_value, 10000,
>  					goal->target_value));
> +
> +		if (goal->metric == DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP &&
> +		    trace_damos_node_eligible_mem_bp_enabled()) {
> +			unsigned int cidx = 0, sidx = 0;
> +			struct damos *siter;
> +
> +			damon_for_each_scheme(siter, c) {
> +				if (siter == s)
> +					break;
> +				sidx++;
> +			}
> +			trace_damos_node_eligible_mem_bp(cidx, sidx,
> +					goal->nid,
> +					goal->target_value,
> +					goal->current_value);
> +		}
>  	}
>  
>  	return highest_score;
> 
> base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4
> -- 
> 2.54.0 (Apple Git-157)
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
