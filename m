Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478883;
	b=K+59hAJYaYkqX+4MVGH3V5lvmC3BSdpAA+i06TR1BozcB8imlUPlKeSrCG8cmiV2Yczb
	 H5GYS2yvkfBH8utRNrzN392WOnGY7b9E7UUGySIrNLgDi7X/wYaM5tRhDWUbKPoP+Xwpt
	 s4oHWxRHuWD4yTPq3AWg5tWZqioA06EJMi/GoOwVNX/kWJdhnnSYY7p8NdbYTp7bvzofe
	 slc1VA0cyAnBs/5KS0yH59VYn+mMZS5loMEot4F4lluELZGdjtEdJVmFDileFqWK0GTHm
	 ExNFS30LEa6VCOVDRzbScL+Hopq9dTciIh37VmhOSjaJuMuoS4+x5jjnUaFZjTrmtCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S1lS42QJJDjNrflFWEXF0zE/DczLdsybPyVpeNgPhA8=;
	b=aVQ4u8ubt4A/SYOeMQn8E8QJH9gD5sseTZ0x6fY3P91UReumKoYWZN+fbGbt9xw3Y10w
	 O60ONt/WQFg7HmrEt5dGy45k90DZUuODgZXzm7evFy+3g+KBWRuqzqbYTPm/VxR8mONmP
	 7DzO77yA62mXArtXWfStrc7fGEQD5zawW4UTlJAuBhEvlZStoyt1EOlMVYUGxKIEno83J
	 KlXU5iE9VCwX5Ry5Pf92sKC9AE2UosU8yHDlLIH73qR7wxcB42V25FEDsrCNKwxCev4JG
	 hc3e+Nq3TxPMIB5Kbcpgs8TuZP6xE5NyllDKih1cP15Xs+IjkeJU2B/ttnsW2C7ORQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmTEjqT8;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD2606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CD2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmTEjqT8
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so6166912eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478882; x=1795083682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1lS42QJJDjNrflFWEXF0zE/DczLdsybPyVpeNgPhA8=;
        b=wmTEjqT8OL9XZ6YSKLd0OtvFc+uCpTmipNxc4GP8iQc2Dg4JdG+C8j+kuMuluUjfYv
         bKDuG2TNdSLZReqyqoZuRelmvZm1D5Tjp1paitQrLsApzoMjRvZeES4+9qJ8/Gb3adcX
         IQFLEWx4mZFc6LcGxgQw8V0XghCf20XlVw15kYhilQpzyEsC9/ab4ImJb8KfpENokyx7
         1n2yknj2GXZmoN0WoSAkTCTC5Jmu6yGcQg0Oj5PH8fH0jqx0kG1Xqd9o2MGbbRK6iUFP
         O78CMo7vftnWtYbAbqg32WUA6YkeRKv9VSrxZjTma+NznNPlVY2/BHOF9wVwPPYYR5cn
         EqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478882; x=1795083682;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1lS42QJJDjNrflFWEXF0zE/DczLdsybPyVpeNgPhA8=;
        b=oVwejvkQTsY+I9sNK4eKq3jGDF7frsd695sD6Uw5qvSecJjLrL5NNuW+8AA2O6rGTH
         dzJm+xGEYl84nq+VZ4tX96j5uZCGx9h5uJwWtex3ZmpijamwiaV6aEz/WCSxE3WQQNJh
         D+cR+bdPNBGjB7E/jCzyZ8voqsySB/frnUHB1Hi240Zdo7Yqug2g/Imx9fRkW1/hzHMX
         jzbobhj8sxEpmU7pCNXPl77lRtIGklCYR9FzifP/lBiUCUp8/vH1s5FokNUgnJX3z9ok
         TDNRTycDeS20i8wKZ7/nBShAyBspu0E0EpBqEs+IuoPY1qEzQ1Hn+bOKQqd/AkU9a7st
         VPgA==
X-Forwarded-Encrypted: i=1; AL+hErFliv5VFG9qzf1hVlg/ZuswyiQHfn9LcsxS50TK9lXJqtILZSzKUERzqNnaOEcPyxcecuNSVeVHKUry+cG9GiQKLYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jsyB/0PQqV5Pxo0rd43WHyQtavfoEMZgsrOK0l1RhOoyXCIyM
	JRPAu14ku0sgeEBgOYtR6q9NWEzvwp5ub6irjUr5lAVVwm+za82s/eKzMGr2KQICuNk=
X-Gm-Gg: AYBFou1PyRcXckkRwYX+eM1ClA/IehQwnv61g8KlReZL92TVB3G4SjzO4GbbPXtFzC5
	r2dpkwRe+MSkz/n3r8MwM0N+miov5+tDFkOmVipRV8Cw7vaSNvbMRk8BBBvEYnRgJwElxBnrny0
	ehPlwIA+ib5OOOv/23iWQTj9lqZrcafde4YztRdO7mBieL9cdRuPMaZsoMwIob8/v7R8HWRN13y
	IhPapca/FWCsg3YzI9FuNeYgBrq5a32wp+p7almLJJYh2zEG8+3JUUhS5ZJ3neevs6NSd1Ttb3v
	lIU0Un4PnluoytFukC7PJqDBnuRhJ95F4hRVRMpjpH0FwZCOWlcIILGqhSuGwW++3astzyt1A/Z
	5rvMEfjfqjXlCIjWRIDc+EKbh4HHR5xUdupAeHmpCunkyR3Vym5IdbC5vg45+exNHwiL3RWg6g1
	K32wbgrJfnXp4YUUzmj3qCbKppknXJnUKx31WnG8YZw0NbmbsMUDhFqhGWjdIMKXTY+371laQVb
	qSTaiaamNV3yNloSCr6qli/mrtL0sZuGrtE2LWKdzx2pxE9cDw/oY6zC9fAV6/d4pyY6xR8vf7r
	5PnqYO7YPKnlQxdZXKyim9Tjok1YLoQVk8YZMT7p4g==
X-Received: by 2002:a05:7301:5f01:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-37685b80487mr7910437eec.10.1794478881435;
        Thu, 12 Nov 2026 02:21:21 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm52398182eec.16.2026.11.12.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:21:21 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/10] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Thu, 12 Nov 2026 18:20:20 +0800
Message-ID: <179447882048.254241.2527227025791137084@gmail.com>
In-Reply-To: <20261028220120.4005187-3-crwood@redhat.com>
References: <20261028220120.4005187-3-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 17:01:20 -0500
Crystal Wood <crwood@redhat.com> wrote:

> We can get here on timerlat with OSN_WORKLOAD cleared via
> osnoise_hotplug_workfn().

Confirming this from the other side, because it is worse than a stray
thread.  On 7.3-rc7, with `rtla timerlat top -q -c 0,1` and cpu1 cycled
offline and back online mid-run, the CPU coming up installs a
"timerlat/1" kthread even though OSN_WORKLOAD is clear.  stop_kthread()
picks the teardown path from the *current* OSN_WORKLOAD, so when the
trace stops it takes the user-thread branch for that kthread:

    WARNING: at stop_kthread+0xc6/0xd0, CPU#1: rtla/57
    WARNING: at __put_task_struct+0xdf/0x100, CPU#1: timerlat/1/72
    WARNING: at free_task+0x7d/0x90, CPU#1: kthreadd/2
    BUG: kernel NULL pointer dereference, address: 0000000000000018  (repeated)

kill_pid() plus put_task_struct() is only right for the user thread,
which owns the reference taken in timerlat_fd_open().  A kthread is owned
by kthread_stop(), so the extra put frees it while it is still running.
A plain offline (never bringing the CPU back) does not reproduce it,
because nothing calls start_kthread() then.  So 02/10 fixes a null-deref
here, not just a redundant thread.

One thing about the series itself:

02/10 sets osn->sampling, but `struct osnoise_variables *osn` is not
declared in start_kthread() until 04/10:

    @@ -2053,15 +2081,18 @@ static int start_kthread(unsigned int cpu)
    +	struct osnoise_variables *osn = cpu_osn_var(cpu);

so 02/10 alone does not compile with CONFIG_OSNOISE_TRACER=y.  Sashiko
flagged this on v6 and it looks like it is still there in the posted
version.  I applied 02/10 on its own on 7.3-rc7 to be sure:

    kernel/trace/trace_osnoise.c: In function 'start_kthread':
    kernel/trace/trace_osnoise.c:2043:25: error: 'osn' undeclared (first use in this function)
     2043 |                         osn->sampling = true;

    +	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
    +		if (!timerlat_enabled())
    +			osn->sampling = true;

Either move the "osn" declaration into 02/10, or keep
`cpu_osn_var(cpu)->sampling` in this patch and let 04/10 switch it.  The
second keeps each patch buildable on its own, which helps anyone
bisecting the series.

FWIW I also checked the "elder kernels deliver SIGKILL" note you added to
timerlat-tracer.rst in 05/10: on 7.3-rc7 the user thread really is gone
after offline, and rtla's supervisor only decrements its count, it never
reforks.  So that paragraph reads correctly to me.

Thanks,
Chaosheng

