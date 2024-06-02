Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3028E3;
	Sun,  2 Jun 2024 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717297293; cv=none; b=uywjucs5ojkkktEiAdS2Rv39HH2JVO89SWLUhs8Zf48ei2aeAOc+nq3qvuU1QsMfIAsfwjvAy6rKzmlNT1QDjBbA6f/gvwUJftngcImF9erGNAu2ZUcIY0wi3ujjOWlNacU0ieQLpTPiW3juoPNwPqoj8wYTDZhgYl9OhNb60qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717297293; c=relaxed/simple;
	bh=JdO1pla7RFG+6UHfAeQ916BDviLKRzz6j8TGIcyMfZM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i+EgZXbfRJL4jyFvd1UO8smI484UAOLmXHdGVjnJnZsB4b5MsjU4LG2NNwQCkCzXSKopLAWdeSY0P8NG1AxYSbd1IdBWxRO13JqVySLTpjy5mhn77tVyldbP6u68n2Yli2dyvKcB+llqAqPgiUz+tkq57qRdsBjBp9y/4z0kkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5FFX5TN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5FFX5TN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D261C3277B;
	Sun,  2 Jun 2024 03:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717297292;
	bh=JdO1pla7RFG+6UHfAeQ916BDviLKRzz6j8TGIcyMfZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a5FFX5TNC2FhkIDarq92cTIX2ri7hHaT0ONJHUJYOePg3zFsOHgDvb4HbRvRaRUnP
	 IzlSeY5xswSEltgPTdKymaesNJ5aflLRtTP60evxbCAHSTVYk+qXpRyHzInrPlm0Hy
	 rytVtWBUbarh/3dJUc9YoZDxbuxKzmGAS5voa8Ui0dy2CYO8tAM9095fX7w7oNZO1i
	 HqX0t4QoDEcbJoa4KGHjKcq+yLBN8WmSaDqOrfnfRS++jRrrUMvTUt5MvV+SJZBBMg
	 RrL7/vooAQTszcN26E1JoT++g5hbjuh7uufyH1v4FRBlV7beeAVlR2wO2s4Fn0RFxc
	 NNJtgMc0PmiVw==
Date: Sun, 2 Jun 2024 12:01:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/test_*.ko
Message-Id: <20240602120126.bdf79b0a209ad016f8a91a73@kernel.org>
In-Reply-To: <20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com>
References: <20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 15:19:39 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> make allmodconfig && make W=1 C=1 reports for lib/test_*.ko:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hexdump.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dhry.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_firmware.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sysctl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hash.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ida.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_list_sort.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_min_heap.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_module.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sort.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_user_copy.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_keys.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_key_base.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_memcat_p.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_blackhole_dev.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_meminit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_free_pages.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kprobes.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ref_tracker.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bits.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
[...]

> diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
> index 0648f7154f5c..e707f7b3a366 100644
> --- a/lib/test_kprobes.c
> +++ b/lib/test_kprobes.c
> @@ -400,4 +400,5 @@ static struct kunit_suite kprobes_test_suite = {
>  
>  kunit_test_suites(&kprobes_test_suite);
>  
> +MODULE_DESCRIPTION("simple sanity test for *probes");

nit: Could you make it "simple sanity test for k*probes" ? because
there is test_fprobe.c.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
