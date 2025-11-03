Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08F31B83B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182654; cv=none; b=NvrWmlc5V+DqcvwZGLmHjRXaMl2OEmuD/0W0LnvcynsPAUx05FdK2YvPcEcdteygE+O8ZHZyd8MLFK9o6ULIgNBnp70XIQro+yw+Ou/DZ1+RiBn+25DTyMxRdYk1Py67fgDkQmTta6sUOb3rahFucfQFSNP/SkLEtsRL4Jq/6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182654; c=relaxed/simple;
	bh=LLHqC3l86SAf4eQgDTCXXldbB1yoNhfIN8WdNZReQ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIuPoCU4olqgvrxxaeyXhs3kHgQ1W+TPyIXyyQzr6jxQwfolX+RR5OdxmHo8EIKuSRw6SNBsNQCR3GrXMHVgvJktOXiZ5lPSrwy/pFFHptaBVg/3pkTWLiDc8AvAbXgzVlT6xUxrVOTM34poHMiiY9pwXtrjEHEtHW0ec/jtWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+Ikn7+g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+Ikn7+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762182650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjH26HUdRaQN1OwrdsvI3tdNLG3MV3oKiNFyejczIQQ=;
	b=b+Ikn7+gEmCZFE5AJ33du8SiQy6sI471XNgyziBIwJ9jUJ2RSBGnQ24qkTQHzjUgnG5NR2
	2qD9WKjBBIyA5KXqz0Z1ueCd3FElcrgyv9m6o5vSF1Tk6tjI8PLsOdySZet1LrnBjzan1S
	f06FGSxL7HpsQH2atzFMfPCc+oPgMxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-pSjm5ei8MzS8IPzH0CXRgQ-1; Mon,
 03 Nov 2025 10:10:47 -0500
X-MC-Unique: pSjm5ei8MzS8IPzH0CXRgQ-1
X-Mimecast-MFC-AGG-ID: pSjm5ei8MzS8IPzH0CXRgQ_1762182646
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96B9418009C2;
	Mon,  3 Nov 2025 15:10:46 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A405219540DB;
	Mon,  3 Nov 2025 15:10:41 +0000 (UTC)
Date: Mon, 3 Nov 2025 12:10:39 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 4/7] rtla/tests: Test BPF action program
Message-ID: <u4jf3ut26njnm63qgyfhq5xik7zhioecjzffok2h6jmd5utd7g@2ptjrmuvbehq>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-5-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-5-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 27, 2025 at 04:33:58PM +0100, Tomas Glozar wrote:
> Add a test that implements a BPF program writing to a test map, which
> is attached to RTLA via --bpf-action to be executed on theshold
> overflow.
> 
> A combination of --on-threshold shell with bpftool (which is always
> present if BPF support is enabled) is used to check whether the BPF
> program has executed successfully.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/Makefile                   | 10 ++++++--
>  tools/tracing/rtla/tests/bpf/bpf_action_map.c | 25 +++++++++++++++++++
>  tools/tracing/rtla/tests/timerlat.t           | 15 +++++++++++
>  3 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 5f1529ce3693..aef814b639b7 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -76,12 +76,18 @@ src/timerlat.skel.h: src/timerlat.bpf.o
>  
>  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@

I didn't understand why the filter function is needed. $< or $^ seems
enough.

> +
> +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> +	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
>  else
>  src/timerlat.skel.h:
>  	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
>  
>  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
>  	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
> +
> +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> +	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action_map.o"

Why not just not creating the targets if BPF is not enabled?

>  endif
>  
>  $(RTLA): $(RTLA_IN)
> @@ -103,7 +109,7 @@ clean: doc_clean fixdep-clean
>  	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
>  	$(Q)rm -rf feature
>  	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
> -check: $(RTLA)
> -	RTLA=$(RTLA) prove -o -f tests/
> +check: $(RTLA) tests/bpf/bpf_action_map.o

Will this work if BPF is disabled?

> +	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
>  examples: example/timerlat_bpf_action.o
>  .PHONY: FORCE clean check
> diff --git a/tools/tracing/rtla/tests/bpf/bpf_action_map.c b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
> new file mode 100644
> index 000000000000..1686e0b858e6
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char LICENSE[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, unsigned int);
> +	__type(value, unsigned long long);
> +} rtla_test_map SEC(".maps");
> +
> +struct trace_event_raw_timerlat_sample;
> +
> +SEC("tp/timerlat_action")
> +int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
> +{
> +	unsigned int key = 0;
> +	unsigned long long value = 42;
> +
> +	bpf_map_update_elem(&rtla_test_map, &key, &value, BPF_ANY);
> +
> +	return 0;
> +}
> diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
> index b5d1e7260a9b..89e28cc6df82 100644
> --- a/tools/tracing/rtla/tests/timerlat.t
> +++ b/tools/tracing/rtla/tests/timerlat.t
> @@ -67,6 +67,21 @@ check "hist with trace output at end" \
>  	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
>  check "top with trace output at end" \
>  	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
> +
> +# BPF action program tests
> +if [ "$option" -eq 0 ]
> +then
> +	# Test BPF action program properly in BPF mode
> +	[ -z "$BPFTOOL" ] && BPFTOOL=bpftool
> +	check "hist with BPF action program (BPF mode)" \
> +		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
> +		2 '"value": 42'
> +else
> +	# Test BPF action program failure in non-BPF mode
> +	check "hist with BPF action program (non-BPF mode)" \
> +		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
> +		1 "BPF actions are not supported in tracefs-only mode"
> +fi
>  done
>  
>  test_end
> -- 
> 2.51.0
> 

