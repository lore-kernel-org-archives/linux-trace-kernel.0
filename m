Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F8356777
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Aug 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544271; cv=none; b=T2UgMJVQucpsxadCj8yqmwhA36km30ElLswCnhUlY33PV3obhqZsPtuiwK0udojGNEQ/5cH+qNKSYsC4qamx+5wOuIQaAue5bf7GJJrIPz9gJPncEZdGDWrqE8slnQTL+usuJObAGVxuITavA6068+JZa5/VS1EvkYQFzcCmHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544271; c=relaxed/simple;
	bh=DTBwgs8S1sAi2koYnIwWweu8EC1Mh2QZ7r67IGibE4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B7QP5k7i5JwrOkGb+n/i7ticraWqV9Mpx/0749RJNvC4YrNcjoqwrhy7A+1RsD1q7foCaUjWJgkyblcnIr248eQANF0y7qSDib2HD+VqL0X+2BuBa+/yZPOnhjaOPdFelQMUadC68U3yiNQ6XdCtZtOg2eVN6WgEWalubtNoz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmOnfbkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmOnfbkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785544268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zqTqj3+/j/AbFq2RoVrHCV42PTj4hoEfVpDtllzCIrc=;
	b=EmOnfbkZIzuwEetivHSSo1hjTmDbEsc5POV8omSdzV7rmbHnRSL/G8H40R8EYalJW2DDpI
	HnHFTCYCDoYlqp+MOkgWhmDR00oFrV8XPdHlDzBf/sP5DXNnXFToXZ/t7Zo4UjOzKX3BRg
	/L2AweOlVuW1lMp2vG0aom9QrkhgyQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-IM_ZwtJiOAmahgM67owaQg-1; Fri,
 31 Jul 2026 20:31:06 -0400
X-MC-Unique: IM_ZwtJiOAmahgM67owaQg-1
X-Mimecast-MFC-AGG-ID: IM_ZwtJiOAmahgM67owaQg_1785544264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0504A1800348;
	Sat,  1 Aug 2026 00:31:04 +0000 (UTC)
Received: from redhat.com (unknown [10.22.88.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2236330002E9;
	Sat,  1 Aug 2026 00:31:01 +0000 (UTC)
Date: Fri, 31 Jul 2026 20:30:58 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
	corbet@lwn.net, jpoimboe@kernel.org, shuah@kernel.org,
	jolsa@kernel.org, mhiramat@kernel.org, stable@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <am0-QoUNQo4p2sBg@redhat.com>
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
 <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: OeZBnZrOSy7PoQ8nB8Ipm3ztWpvFQRS6SIbC_M1PpNY_1785544264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 01:53:58PM -0400, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  .../testing/selftests/livepatch/functions.sh  | 13 ++++++
>  .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
>  2 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 30dc677b2f45..7fa4bda70221 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -126,6 +126,19 @@ function set_ftrace_enabled() {
>  	echo "livepatch: kernel.ftrace_enabled = $result" > /dev/kmsg
>  }
>  
> +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=0
> +#	can still disable ftrace on this kernel. Newer kernels deprecate
> +#	the knob and always refuse the write with -EOPNOTSUPP.
> +function ftrace_disable_supported() {
> +	local result
> +
> +	sysctl -q kernel.ftrace_enabled=0 &> /dev/null
> +	result=$(sysctl --values kernel.ftrace_enabled)
> +	sysctl -q kernel.ftrace_enabled=1 &> /dev/null
> +
> +	[[ "$result" == "0" ]]
> +}

Small nit: AFAICT, it doesn't really affect the test pattern, but it
would be a bit cleaner if this function restored the original value
instead of always turning it on, like (untested):

	orig=$(sysctl --values kernel.ftrace_enabled)
	sysctl -q kernel.ftrace_enabled=0 &> /dev/null
	result=$(sysctl --values kernel.ftrace_enabled)
	sysctl -q "kernel.ftrace_enabled=$orig" &> /dev/null

	[[ "$result" == "0" ]]

--
Joe

