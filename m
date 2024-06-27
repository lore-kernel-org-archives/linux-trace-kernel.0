Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE71946BB;
	Thu, 27 Jun 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496569; cv=none; b=Av1PPbljJ+aSUEEwaetP4OJucO5xAEi4V7axNVwfFG7mqU+q5QZTBO/kioau0G7gznq6MEOFrdS7RIHW2noEkhrPhIi51JzSHf6Jrpzc6qgqYhuD1u8STDaINfYvkP/vg7YZk7AhzI3LcplH7d1oaz3eGQAsjbTvCJhFDvZc9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496569; c=relaxed/simple;
	bh=EYuzYLAE3jR3L28Pf0IUMq8SpOUoGWbEFJINkfcWQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVnQY2dx1j0nQ4jXFjP1Iw6EAU7ZiHrWT7lm5uOezekrbqv7+PT+MFE2WW0PsGOLbTdxwckI+kUulTgzPhiVfzRypHLS5+pTIMK4DKARgge74A6nUaxo5vgimnxIdW+hiYcCsMSs3zj79LIHBvPLCxD8YZ+oIk+TRNIMsaFDlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5858CC2BBFC;
	Thu, 27 Jun 2024 13:56:07 +0000 (UTC)
Date: Thu, 27 Jun 2024 09:56:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj
 <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-trace-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 4/4] trace: platform/x86/intel/ifs: Add SBAF trace
 support
Message-ID: <20240627095604.12eb1bca@rorschach.local.home>
In-Reply-To: <20240627023516.3783454-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
	<20240627023516.3783454-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 02:35:16 +0000
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> Add tracing support for the SBAF IFS tests, which may be useful for
> debugging systems that fail these tests. Log details like test content
> batch number, SBAF bundle ID, program index and the exact errors or
> warnings encountered by each HT thread during the test.
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
> index 0d88ebf2c980..9c7413de432b 100644
> --- a/include/trace/events/intel_ifs.h
> +++ b/include/trace/events/intel_ifs.h
> @@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
>  		__entry->status)
>  );
>  
> +TRACE_EVENT(ifs_sbaf,
> +
> +	TP_PROTO(int batch, union ifs_sbaf activate, union ifs_sbaf_status status),
> +
> +	TP_ARGS(batch, activate, status),
> +
> +	TP_STRUCT__entry(
> +		__field(	int,	batch	)
> +		__field(	u64,	status	)

Please put the 64 bit status field before the 32 bit batch field,
otherwise this will likely create a 4 byte hole between the two fields.
Space on the ring buffer is expensive real-estate.

-- Steve

> +		__field(	u16,	bundle	)
> +		__field(	u16,	pgm	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->batch	= batch;
> +		__entry->bundle	= activate.bundle_idx;
> +		__entry->pgm	= activate.pgm_idx;
> +		__entry->status	= status.data;
> +	),
> +
> +	TP_printk("batch: 0x%.2x, bundle_idx: 0x%.4x, pgm_idx: 0x%.4x, status: 0x%.16llx",
> +		__entry->batch,
> +		__entry->bundle,
> +		__entry->pgm,
> +		__entry->status)
> +);
> +
>  #endif /* _TRACE_IFS_H */
>  
>  /* This part must be outside protection */
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index bdb31b2f45b4..69ee0eb72025 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -530,6 +530,7 @@ static int dosbaf(void *data)
>  	 */
>  	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
>  	rdmsrl(MSR_SBAF_STATUS, status.data);
> +	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
>  
>  	/* Pass back the result of the test */
>  	if (cpu == first)

