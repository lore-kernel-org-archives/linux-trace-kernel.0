Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948C2820C6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181108; cv=none; b=qEVlNR+9rL0nsW2qFb3DFkJmO8SASRc1iPhXq9TJL7UBEBG1KqYVfA2wMt/S4mjEzfaMjekTzvmjZtxiPEkJT3785wPvQ00UcbFUVwcOBFHHCX8I4k8gyomcaiKttcSWrWAiENG/mtmV8MEFaf+86fZ0WG4aNUUGd+z6pHVd30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181108; c=relaxed/simple;
	bh=tcHQ8+NP5XolVw/PMnhxsjzK3oDK2++3aoPUNdPMWl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSfQ9oWJodtZULppOmoPlthJMcmx1CmYmBvr3/xQ4eyKIJfM4/Acv35qTbbNB/nLbHbCgO34nS7BdOd+QTfXroKQBpnAsAY19/szJPa0hrpNZANeZGZNzRlI8IbL0+jcV0VKJF27cvwIlxg46I2dOlBNZMyGCvcNlYfiaycMWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEOenl6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEOenl6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762181105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKe5T4XkgUNmc72tStyCh8sP7MNTXayWol7Zf/AYXFQ=;
	b=NEOenl6SAJdGNctjupNTM6agAWT06J0iZrHwOJFjTTY8tQL/1HvcCTjK66xR6Ke3A/M3ZS
	IDrroQ2zYJhruU9tZ8qk3xsUu5TqO1qyeDt1/iLgN4y531THJrAJc2oLOVfeHXftV2Ncu1
	n0gonHl3qMqlBPNsXRjTq9etM2TrsP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-4aS0kB8bPqm4Ue7MfgfQFg-1; Mon,
 03 Nov 2025 09:45:04 -0500
X-MC-Unique: 4aS0kB8bPqm4Ue7MfgfQFg-1
X-Mimecast-MFC-AGG-ID: 4aS0kB8bPqm4Ue7MfgfQFg_1762181103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB9831956050;
	Mon,  3 Nov 2025 14:45:02 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DDA801800452;
	Mon,  3 Nov 2025 14:44:58 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:44:56 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 2/7] rtla/timerlat: Add --bpf-action option
Message-ID: <liouklnl72kulibowk33roalgtjor24u3h6hfbuzudlodasdvz@fhy2zeif43nk>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-3-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Oct 27, 2025 at 04:33:56PM +0100, Tomas Glozar wrote:
> Add option --bpf-action that allows the user to attach an external BPF
> program that will be executed via BPF tail call on latency threshold
> overflow.
> 
> Executing additional BPF code on latency threshold overflow allows doing
> doing low-latency and in-kernel troubleshooting of the cause of the

typo: double "doing"

> overflow.
> 
> The option takes an argument, which is a path to a BPF ELF file
> expected to contain a function named "action_handler" in a section named
> "tp/timerlat_action" (the section is necessary for libbpf to assign the
> correct BPF program type to it).
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat.c      | 11 ++++++
>  tools/tracing/rtla/src/timerlat.h      |  2 +-
>  tools/tracing/rtla/src/timerlat_bpf.c  | 53 ++++++++++++++++++++++++++
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++-
>  tools/tracing/rtla/src/timerlat_hist.c |  5 +++
>  tools/tracing/rtla/src/timerlat_top.c  |  5 +++
>  6 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> index b69212874127..6907a323f9ec 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -48,6 +48,17 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
>  		}
>  	}
>  
> +	/* Check if BPF action program is requested but BPF is not available */
> +	if (params->bpf_action_program) {
> +		if (params->mode == TRACING_MODE_TRACEFS) {
> +			err_msg("BPF actions are not supported in tracefs-only mode\n");

I would just emit a warning to the user and proceed ignoring the bpf action argument.

> +			goto out_err;
> +		}
> +
> +		if (timerlat_load_bpf_action_program(params->bpf_action_program))
> +			goto out_err;
> +	}
> +
>  	if (params->mode != TRACING_MODE_BPF) {
>  		/*
>  		 * In tracefs and mixed mode, timerlat tracer handles stopping
> diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
> index fd6065f48bb7..8dd5d134ce08 100644
> --- a/tools/tracing/rtla/src/timerlat.h
> +++ b/tools/tracing/rtla/src/timerlat.h
> @@ -27,6 +27,7 @@ struct timerlat_params {
>  	int			dump_tasks;
>  	int			deepest_idle_state;
>  	enum timerlat_tracing_mode mode;
> +	const char		*bpf_action_program;
>  };
>  
>  #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
> @@ -36,4 +37,3 @@ int timerlat_main(int argc, char *argv[]);
>  int timerlat_enable(struct osnoise_tool *tool);
>  void timerlat_analyze(struct osnoise_tool *tool, bool stopped);
>  void timerlat_free(struct osnoise_tool *tool);
> -
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
> index 1d619e502c65..05adf18303df 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -7,6 +7,10 @@
>  
>  static struct timerlat_bpf *bpf;
>  
> +/* BPF object and program for action program */
> +static struct bpf_object *obj;
> +static struct bpf_program *prog;
> +
>  /*
>   * timerlat_bpf_init - load and initialize BPF program to collect timerlat data
>   */
> @@ -96,6 +100,11 @@ void timerlat_bpf_detach(void)
>  void timerlat_bpf_destroy(void)
>  {
>  	timerlat_bpf__destroy(bpf);
> +	bpf = NULL;
> +	if (obj)
> +		bpf_object__close(obj);
> +	obj = NULL;
> +	prog = NULL;
>  }
>  
>  static int handle_rb_event(void *ctx, void *data, size_t data_sz)
> @@ -190,4 +199,48 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
>  			 bpf->maps.summary_user,
>  			 key, value_irq, value_thread, value_user, cpus);
>  }
> +
> +/*
> + * timerlat_load_bpf_action_program - load and register a BPF action program
> + */
> +int timerlat_load_bpf_action_program(const char *program_path)
> +{
> +	int err;
> +
> +	obj = bpf_object__open_file(program_path, NULL);
> +	if (!obj) {
> +		err_msg("Failed to open BPF action program: %s\n", program_path);
> +		goto out_err;
> +	}
> +
> +	err = bpf_object__load(obj);
> +	if (err) {
> +		err_msg("Failed to load BPF action program: %s\n", program_path);
> +		goto out_obj_err;
> +	}
> +
> +	prog = bpf_object__find_program_by_name(obj, "action_handler");
> +	if (!prog) {
> +		err_msg("BPF action program must have 'action_handler' function: %s\n",
> +			program_path);
> +		goto out_obj_err;
> +	}
> +
> +	err = timerlat_bpf_set_action(prog);
> +	if (err) {
> +		err_msg("Failed to register BPF action program: %s\n", program_path);
> +		goto out_prog_err;
> +	}
> +
> +	return 0;
> +
> +out_prog_err:
> +	prog = NULL;
> +out_obj_err:
> +	bpf_object__close(obj);
> +	obj = NULL;
> +out_err:
> +	return 1;
> +}
> +
>  #endif /* HAVE_BPF_SKEL */
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
> index b5009092c7a3..169abeaf4363 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.h
> +++ b/tools/tracing/rtla/src/timerlat_bpf.h
> @@ -30,7 +30,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
>  				   long long *value_thread,
>  				   long long *value_user,
>  				   int cpus);
> -
> +int timerlat_load_bpf_action_program(const char *program_path);
>  static inline int have_libbpf_support(void) { return 1; }
>  #else
>  static inline int timerlat_bpf_init(struct timerlat_params *params)
> @@ -58,6 +58,10 @@ static inline int timerlat_bpf_get_summary_value(enum summary_field key,
>  {
>  	return -1;
>  }
> +static inline int timerlat_load_bpf_action_program(const char *program_path)
> +{
> +	return -1;
> +}
>  static inline int have_libbpf_support(void) { return 0; }
>  #endif /* HAVE_BPF_SKEL */
>  #endif /* __bpf__ */
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 606c1688057b..5e639cc34f64 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -763,6 +763,7 @@ static void timerlat_hist_usage(char *usage)
>  		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
>  		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
>  		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
> +		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
>  		NULL,
>  	};
>  
> @@ -853,6 +854,7 @@ static struct common_params
>  			{"deepest-idle-state",	required_argument,	0, '\4'},
>  			{"on-threshold",	required_argument,	0, '\5'},
>  			{"on-end",		required_argument,	0, '\6'},
> +			{"bpf-action",		required_argument,	0, '\7'},
>  			{0, 0, 0, 0}
>  		};
>  
> @@ -1062,6 +1064,9 @@ static struct common_params
>  				exit(EXIT_FAILURE);
>  			}
>  			break;
> +		case '\7':
> +			params->bpf_action_program = optarg;
> +			break;
>  		default:
>  			timerlat_hist_usage("Invalid option");
>  		}
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index fc479a0dcb59..da5d5db1bc17 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -521,6 +521,7 @@ static void timerlat_top_usage(char *usage)
>  		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
>  		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
>  		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
> +		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
>  		NULL,
>  	};
>  
> @@ -603,6 +604,7 @@ static struct common_params
>  			{"deepest-idle-state",	required_argument,	0, '8'},
>  			{"on-threshold",	required_argument,	0, '9'},
>  			{"on-end",		required_argument,	0, '\1'},
> +			{"bpf-action",		required_argument,	0, '\2'},
>  			{0, 0, 0, 0}
>  		};
>  
> @@ -798,6 +800,9 @@ static struct common_params
>  				exit(EXIT_FAILURE);
>  			}
>  			break;
> +		case '\2':
> +			params->bpf_action_program = optarg;
> +			break;
>  		default:
>  			timerlat_top_usage("Invalid option");
>  		}
> -- 
> 2.51.0
> 

