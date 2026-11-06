Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940876;
	b=dvTe1Hso6CbKxVqa5fhb5/Brk/mmY8h5MIuCEEo2xFamoJacspvDaKZ9toWl7U6pUNs5
	 ioaBaceOdRaFNLAIx+cBBbq2N0LyT292IE3p5YDGCyLkOaGOhvIxJ/Jw+ke629jBFyVrg
	 MAoZe3OOXX1Qjf+aLTZyVNOS0q9S0IRhoMNHeTdhJSApuISQObEqhafYGYtGDZmuGq8Vm
	 VosIbs9kP8EDNwdVCViPRKkDwucZ5wVYjUsrbNTXdKm59pWsUDvLQMJwapA8X88vkqqD4
	 dI8zy9V5iez2KIYWkcDbcf6PLV8oKkCSQkxEuAmGbWM8R/IEvEQ5I7OuMiqTSj/yvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0XXMzfFrMuhQ4F+XnXsFq3w4XgRZy5QKJgrtlHXBe4k=;
	b=Z+mfnvAWBbJbINDSqYFxlEb1zgiSQ4HQUbg0sbmvE9X3Nt3wX5uYy/PjFRSeefj3VGyd
	 SYHOyhVZKuBzLA4s9vnb2Cz0ahekA/+uAZX71sMz1UdszzbR/JqFMR2f8lfZsOHoerITY
	 2vcsp4+dqHh6vQcp9ghre1pOmlAE952StxLHS3bvTSz8soMhkiOv5IWKp6qQED2uTcmPL
	 5PbmQEVGz2UKOLkmNzPCXNY04X6FiSckUc01LKoLzwEA5GTMGkOUSqAO8VTfux+pKOp6Z
	 /dyYxrijJbtQl5ZxaTx/waqWSiRVkcNB1Hf9Eovy/pn8OQ3VYyUtGjBGJvoP5FHXSSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EBCH59/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0E606A328;
	Fri,  6 Nov 2026 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBCH59/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098411F008A3;
	Fri,  6 Nov 2026 04:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940876;
	bh=0XXMzfFrMuhQ4F+XnXsFq3w4XgRZy5QKJgrtlHXBe4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EBCH59/y9hilVF46mpV5nEtKYrzidn9xHBUwOKDUfytSuRZwVtYspUNP9VSGDt28B
	 Rgcbt+W7bpMf+HAtpvA2n/TPaCgvQOAYwqEnL8XlwkeGhIAasR9/HImNm5gNBD3PYe
	 9Zb/bbDwPxZMq/lzrmrFtkTfr94erDv9W98CG3cNvMI+jFeJKo9s/Ob05hig3pBmk/
	 ofL+dsN2MsZI0j58TAMOWaOY3LB7dQdMPMQZolrjbfDIuPIVKgMwUgdg/V6brAVudm
	 6vIgf4K/jcp4FQgXlqhsZWJFs+nn//23p7AyaZHc2S5LvNeZ1/zRnsOvPHZJ5NGVWs
	 z+bsfUwPjBxQg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: kernel test robot <yi1.lai@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>, Vinod Koul <vkoul@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [tracing]  b5cc230af5: WARNING:at_kernel/trace/trace_events.c:#test_double_dereference
Date: Fri, 06 Nov 2026 04:54:33 +0000
Message-ID: <undine-1793940873129741182-d37e5f54bdcb36ed@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <202611060303.c90f27a7-lkp@intel.com>
References: <202611060303.c90f27a7-lkp@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 6 Nov 2026 11:07:56 +0800, kernel test robot <yi1.lai@intel.com> wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#test_double_dereference" on:
> 
> commit: b5cc230af5e536ff752f8bd5c30e23612936d5c3 ("tracing: Warn when an event dereferences a pointer in TP_printk()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-r2309-20261012
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu Cascadelake-Server-noTSX,enforce -smp 4 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202611060303.c90f27a7-lkp@intel.com
> 
> 
> [    0.808840][    T0] ------------[ cut here ]------------
> [    0.810236][    T0] Event hfi1_txq_complete has double dereference in TP_printk: REC->sde ? REC->sde->this_idx : 0

This seems to be expected behavior. Because "REC->sde" can point already
freed/reused object, this should not be allowed. The event must save the
sde->this_idx at TP_fast_assign() instead of recording sde.

In drivers/infiniband/hw/hfi1/trace_tx.h:

DECLARE_EVENT_CLASS(/* AIP  */
        hfi1_ipoib_txq_template,
	...
        TP_printk(/* print  */
                "[%s] txq %llx idx %u sde %llx:%u cpu %d head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
                __get_str(dev),
                (unsigned long long)__entry->txq,
                __entry->idx,
                (unsigned long long)__entry->sde,
                __entry->sde ? __entry->sde->this_idx : 0, // this must be recorded as a value
                __entry->sde ? __entry->sde->cpu : 0,	// ditto


So this is a bug in an infiniband driver.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
