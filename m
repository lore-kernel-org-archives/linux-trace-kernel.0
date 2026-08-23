Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A130EF77
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506379; cv=none; b=j6PuA1TYMzWGM5Lg5ZFjNAYd+aAUeefFqmz4TgbF98KFsJaJXj7EMbrI1KAjN8R0FW78CJADEYH1C7/GgcH0W0cqwklgQK14tQsD1b4GD8pjG2AdpRU5pzpv/LRRKiWbYBwU4V0vENxtRsrUOf02WGqVBXk8+3tK2bBHf/wifNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506379; c=relaxed/simple;
	bh=boZQsOczuILCZZznjjFVgQpFPv8T/sAHwrovvo1ib5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9KGE7TtEzsu8bqRqnxGk7UYZuyyXyGgCEFBpxARJsonNIGIsyZTKgJ4IiiEIu9HIEnq6XIq/edEzk+WhlANTXl1PcllWuwqqRgQe9su+DYG2jKVgR2tnlKH19NnrqwYDX4s3xHkxYX/MsN9CehfR3wayweCAS8ncwypWeb1WVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8GTIVxU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8GTIVxU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1958746a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787506372; x=1788111172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIQqFR/wDal+vyB8bFXJyyDChhCbeLDGnSweN9kNW7M=;
        b=V8GTIVxUU4tlwZNlXLu38uAU9fpifCkKhqkw+3X3CAWEAAHuOpjL/OD4xeiQTOIDn1
         N1UWIDBWA4IkrlA4Ht2cIRTzxzhxqzmqw6FNNuyzi1jGw5Y6vfermHEBnzxIQDKd0EAv
         wBwNynl3lVemweWQpgYjJlHDY3mlFIfOlx0i4HObnvr/id2VGpIFhw2fG5lISALD6Eq9
         1IU6qSbrUm4SQ9fBY0cdGXB6gD1R0o053WAAyAVVRcTM0eIJTzQv5MyQ4/EWGVfcJqez
         bmN7OLk6p92OSonSznJxKgd/WvMOESf1fu9MbsAFE1oTI9HbX18Hg0c6UxTPGmjef8ep
         cyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787506372; x=1788111172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIQqFR/wDal+vyB8bFXJyyDChhCbeLDGnSweN9kNW7M=;
        b=ghjvAZsiHPOn2C3+7JnWN0LzPe4HyiqAdy3PIyTb/yDd+/WWQxgHWCRKUkn7CpzJPP
         kfsSN1ekXazsgHAykq8i27/3rbA551yc6OrFACmO70S5w0v4HLzJuYFgxREti76jtGt+
         pXe4mL60hVDDcnuUe11X2ZeOvZZK8OSHaKGUcCU1MVXL6h1NQvqfxsPpt6ClyQnYhAcV
         32jFShOGTNWatr+tg0H0ggjpHu3iWMvnPmRekkWteAnmaRuk0oXuGSG6FcCJIOu/ZeZT
         JSuZEx01iLmYjowSAQbI+IbtUW1pTX8zkijx1M6SFSEDTqdMmDehrSz5z00RUgLpNjln
         FoTw==
X-Forwarded-Encrypted: i=1; AHgh+RpQYloy3iyaCaiylyE8/U8ZK7DUGbCTnh6zD5SDo0sFto+AzgDD4tCNFH3i1GuFEV3AyhfXU40jlTGRIohsb9S8J7g=@vger.kernel.org
X-Gm-Message-State: AFuF++mTXYTv13XBT9FV/AnipiHRX34mCJavv9SGK7NfMDRBgTFGWiBd
	0f+zqPHXu1f3ncRtGgj5ZXo/ikBTv1aMCz0VX5gNWVFfAdqpMyhDZ327
X-Gm-Gg: AR+sD12WBGG/H2RYzeFCv2p+ifTXzkViOcBhgN4SllfzUsDuBJorqAV7sIvG0TreWJ5
	aFSj6EoWcZGrpWfXXPcZUw+BMfSGapJISb3yZKZ5RihgcLdzsvM4mDrWA9uOmym4UGb+nmULeWK
	nqFVeqK2HC0UcNfw0vLuKnub919oG0imYGIQtnZnouiBq7M2Ij92LHbA4fodPNMSNiTd4gmEasq
	86jHXeXmmwSITEff0lOUygc7fDXJwQsWTTBRJAwswtjJxNfvJqlCVf/00QrgsRw5lb4mzg90Mwf
	CCzhHAP1PwjLGnpbgK6dqiv+IT4jhvBVy9Cfu6FSmPZb6GRINl6H0Kd2MRL3kEm1KvRNFB1TyPE
	AstvYOApFz1VkwoUmtx2V7t7078M74bcSKeHPVLKvOB0NEQc4OSTsfg3zpjH2gG4RcNMFKfV55t
	9tVyEmgYS7itOn5Th+gQuyMxHcxF8ZTN/f2upyfU8hi3qV97EF64mwICg3iXut
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-395c3a06ffcmr34074989a91.12.1787506372214;
        Sun, 23 Aug 2026 10:32:52 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49b4060sm6662395a91.6.2026.08.23.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:32:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 01:32:48 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v5 10/17] verification/rvgen: Add selftests for rvgen
 kunit
Message-ID: <aosuwKH5GOEo0xTN@google.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
 <20260723074534.43521-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723074534.43521-11-gmonaco@redhat.com>

Hi Gabriele,

On Thu, Jul 23, 2026 at 09:45:27AM +0200, Gabriele Monaco wrote:
> The rvgen kunit command patches monitor files and adds necessary
> definitions for kunit tests.
> 
> Add a test case validating its behaviour on dummy generated files and
> comparing it against reference files, like it's done for rvgen monitor.
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks for your patch, which is now commit 7b6246294eb0 upstream.

> ---
>  .../rvgen/tests/golden/test_bak_kunit/Kconfig |   9 +
>  .../golden/test_bak_kunit/test_bak_kunit.c    | 107 +++++++
>  .../golden/test_bak_kunit/test_bak_kunit.h    | 108 ++++++++
>  .../test_bak_kunit/test_bak_kunit_kunit.c     |  33 +++
>  .../test_bak_kunit/test_bak_kunit_kunit.c.bak |   1 +

I noticed a issue regarding the .bak file introduced in this patch.

When running make distclean on the kernel tree, this file gets
automatically deleted. As a result, git tracks this as a deleted file
and leaves a dirty working tree, which is a bit annoying during
development. Would it be possible to use a different extension for this
golden file, such as .backup or something, to prevent it from being
swept up by the generic clean rules?

Regards,
Kuan-Wei

>  .../test_bak_kunit/test_bak_kunit_kunit.h     |  22 ++
>  .../test_bak_kunit/test_bak_kunit_trace.h     |  14 +
>  .../rvgen/tests/golden/test_da_kunit/Kconfig  |   9 +
>  .../golden/test_da_kunit/test_da_kunit.c      | 107 +++++++
>  .../golden/test_da_kunit/test_da_kunit.h      |  47 ++++
>  .../test_da_kunit/test_da_kunit_kunit.c       |  33 +++
>  .../test_da_kunit/test_da_kunit_kunit.h       |  23 ++
>  .../test_da_kunit/test_da_kunit_trace.h       |  15 +
>  .../rvgen/tests/golden/test_ha_kunit/Kconfig  |   9 +
>  .../golden/test_ha_kunit/test_ha_kunit.c      | 260 ++++++++++++++++++
>  .../golden/test_ha_kunit/test_ha_kunit.h      |  88 ++++++
>  .../test_ha_kunit/test_ha_kunit_kunit.c       |  33 +++
>  .../test_ha_kunit/test_ha_kunit_kunit.h       |  24 ++
>  .../test_ha_kunit/test_ha_kunit_trace.h       |  19 ++
>  .../rvgen/tests/golden/test_ltl_kunit/Kconfig |   9 +
>  .../golden/test_ltl_kunit/test_ltl_kunit.c    | 107 +++++++
>  .../golden/test_ltl_kunit/test_ltl_kunit.h    | 108 ++++++++
>  .../test_ltl_kunit/test_ltl_kunit_kunit.c     |  33 +++
>  .../test_ltl_kunit/test_ltl_kunit_kunit.h     |  22 ++
>  .../test_ltl_kunit/test_ltl_kunit_trace.h     |  14 +
>  tools/verification/rvgen/tests/rvgen_kunit.t  |  41 +++
>  26 files changed, 1295 insertions(+)
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/Kconfig
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/Kconfig
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/Kconfig
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/Kconfig
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.c
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.h
>  create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
>  create mode 100644 tools/verification/rvgen/tests/rvgen_kunit.t
> 
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/Kconfig b/tools/verification/rvgen/tests/golden/test_bak_kunit/Kconfig
> new file mode 100644
> index 000000000000..175a416f8b18
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TEST_BAK_KUNIT
> +	depends on RV
> +	# XXX: add dependencies if there
> +	select LTL_MON_EVENTS_ID
> +	bool "test_bak_kunit monitor"
> +	help
> +	  auto-generated
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.c b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.c
> new file mode 100644
> index 000000000000..16579c1c6910
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "test_bak_kunit"
> +
> +/*
> + * XXX: include required tracepoint headers, e.g.,
> + * #include <trace/events/sched.h>
> + */
> +#include <rv_trace.h>
> +
> +
> +/*
> + * This is the self-generated part of the monitor. Generally, there is no need
> + * to touch this section.
> + */
> +#include "test_bak_kunit.h"
> +#include <rv/ltl_monitor.h>
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +	/*
> +	 * This is called everytime the Buchi automaton is triggered.
> +	 *
> +	 * This function could be used to fetch the atomic propositions which
> +	 * are expensive to trace. It is possible only if the atomic proposition
> +	 * does not need to be updated at precise time.
> +	 *
> +	 * It is recommended to use tracepoints and ltl_atom_update() instead.
> +	 */
> +}
> +
> +static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
> +{
> +	/*
> +	 * This should initialize as many atomic propositions as possible.
> +	 *
> +	 * @task_creation indicates whether the task is being created. This is
> +	 * false if the task is already running before the monitor is enabled.
> +	 */
> +	ltl_atom_set(mon, LTL_EVENT_A, true/false);
> +	ltl_atom_set(mon, LTL_EVENT_B, true/false);
> +}
> +
> +/*
> + * This is the instrumentation part of the monitor.
> + *
> + * This is the section where manual work is required. Here the kernel events
> + * are translated into model's event.
> + */
> +static void handle_example_event(void *data, /* XXX: fill header */)
> +{
> +	ltl_atom_update(task, LTL_EVENT_A, true/false);
> +}
> +
> +static int enable_test_bak_kunit(void)
> +{
> +	int retval;
> +
> +	retval = ltl_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("test_bak_kunit", /* XXX: tracepoint */, handle_example_event);
> +
> +	return 0;
> +}
> +
> +static void disable_test_bak_kunit(void)
> +{
> +	rv_detach_trace_probe("test_bak_kunit", /* XXX: tracepoint */, handle_example_event);
> +
> +	ltl_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_this = {
> +	.name = "test_bak_kunit",
> +	.description = "auto-generated",
> +	.enable = enable_test_bak_kunit,
> +	.disable = disable_test_bak_kunit,
> +};
> +
> +static int __init register_test_bak_kunit(void)
> +{
> +	return rv_register_monitor(&rv_this, NULL);
> +}
> +
> +static void __exit unregister_test_bak_kunit(void)
> +{
> +	rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_test_bak_kunit);
> +module_exit(unregister_test_bak_kunit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("rvgen: auto-generated");
> +MODULE_DESCRIPTION("test_bak_kunit: auto-generated");
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.h b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.h
> new file mode 100644
> index 000000000000..2bfe4e37cea7
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * C implementation of Buchi automaton, automatically generated by
> + * tools/verification/rvgen from the linear temporal logic specification.
> + * For further information, see kernel documentation:
> + *   Documentation/trace/rv/linear_temporal_logic.rst
> + */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME test_bak_kunit
> +
> +enum ltl_atom {
> +	LTL_EVENT_A,
> +	LTL_EVENT_B,
> +	LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +	static const char *const names[] = {
> +		"ev_a",
> +		"ev_b",
> +	};
> +
> +	return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +	S0,
> +	S1,
> +	S2,
> +	S3,
> +	S4,
> +	RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);
> +
> +static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +	bool event_b = test_bit(LTL_EVENT_B, mon->atoms);
> +	bool event_a = test_bit(LTL_EVENT_A, mon->atoms);
> +	bool val1 = !event_a;
> +
> +	if (val1)
> +		__set_bit(S0, mon->states);
> +	if (true)
> +		__set_bit(S1, mon->states);
> +	if (event_b)
> +		__set_bit(S4, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
> +{
> +	bool event_b = test_bit(LTL_EVENT_B, mon->atoms);
> +	bool event_a = test_bit(LTL_EVENT_A, mon->atoms);
> +	bool val1 = !event_a;
> +
> +	switch (state) {
> +	case S0:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S1:
> +		if (true)
> +			__set_bit(S1, next);
> +		if (true && val1)
> +			__set_bit(S2, next);
> +		if (event_b && val1)
> +			__set_bit(S3, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S2:
> +		if (true)
> +			__set_bit(S1, next);
> +		if (true && val1)
> +			__set_bit(S2, next);
> +		if (event_b && val1)
> +			__set_bit(S3, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S3:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S4:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	}
> +}
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c
> new file mode 100644
> index 000000000000..e2b9354034cc
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +/*
> + * XXX: include required headers, e.g.,
> + * #include <linux/sched.h>
> + */
> +#include "test_bak_kunit_kunit.h"
> +
> +#if IS_REACHABLE(CONFIG_RV_MON_TEST_BAK_KUNIT)
> +
> +static void rv_test_test_bak_kunit(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx = test->priv;
> +	/*
> +	 * If you need to create task_structs with rv_kunit_alloc_mock_task()
> +	 * do it BEFORE preparing the test.
> +	 */
> +
> +	prepare_test(test, &rv_test_bak_kunit_ops.mon);
> +
> +	/*
> +	 * XXX: write the test here
> +	 * e.g.
> +	 * RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
> +	 *	rv_test_bak_kunit_ops.handle_event(args);
> +	 */
> +}
> +
> +#else
> +#define rv_test_test_bak_kunit rv_test_stub
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
> new file mode 100644
> index 000000000000..f747925bf542
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
> @@ -0,0 +1 @@
> +DUMMY
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.h b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.h
> new file mode 100644
> index 000000000000..585c4803be23
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Automatically generated by rvgen kunit.
> + * May need manual intervention for function prototypes that couldn't be
> + * found (e.g. are in another file) or variables to be exported.
> + */
> +
> +#ifndef __TEST_BAK_KUNIT_KUNIT_H
> +#define __TEST_BAK_KUNIT_KUNIT_H
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +
> +extern const struct rv_test_bak_kunit_ops {
> +	struct rv_kunit_mon mon;
> +	void (*handle_example_event)(void *data, /* XXX: fill header */);
> +} rv_test_bak_kunit_ops;
> +#endif
> +
> +#endif /* __TEST_BAK_KUNIT_KUNIT_H */
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
> new file mode 100644
> index 000000000000..b984208838c4
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_TEST_BAK_KUNIT
> +DEFINE_EVENT(event_ltl_monitor_id, event_test_bak_kunit,
> +	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
> +	     TP_ARGS(task, states, atoms, next));
> +DEFINE_EVENT(error_ltl_monitor_id, error_test_bak_kunit,
> +	     TP_PROTO(struct task_struct *task),
> +	     TP_ARGS(task));
> +#endif /* CONFIG_RV_MON_TEST_BAK_KUNIT */
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/Kconfig b/tools/verification/rvgen/tests/golden/test_da_kunit/Kconfig
> new file mode 100644
> index 000000000000..6d664ba5624d
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TEST_DA_KUNIT
> +	depends on RV
> +	# XXX: add dependencies if there
> +	select DA_MON_EVENTS_IMPLICIT
> +	bool "test_da_kunit monitor"
> +	help
> +	  auto-generated
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.c b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.c
> new file mode 100644
> index 000000000000..effd26548b07
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "test_da_kunit"
> +
> +/*
> + * XXX: include required tracepoint headers, e.g.,
> + * #include <trace/events/sched.h>
> + */
> +#include <rv_trace.h>
> +
> +/*
> + * This is the self-generated part of the monitor. Generally, there is no need
> + * to touch this section.
> + */
> +#define RV_MON_TYPE RV_MON_PER_CPU
> +#include "test_da_kunit.h"
> +#include <rv/da_monitor.h>
> +
> +/*
> + * This is the instrumentation part of the monitor.
> + *
> + * This is the section where manual work is required. Here the kernel events
> + * are translated into model's event.
> + *
> + */
> +static void handle_event_1(void *data, /* XXX: fill header */)
> +{
> +	da_handle_event(event_1_test_da_kunit);
> +}
> +
> +static void handle_event_2(void *data, /* XXX: fill header */)
> +{
> +	/* XXX: validate that this event always leads to the initial state */
> +	da_handle_start_event(event_2_test_da_kunit);
> +}
> +
> +static int enable_test_da_kunit(void)
> +{
> +	int retval;
> +
> +	retval = da_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("test_da_kunit", /* XXX: tracepoint */, handle_event_1);
> +	rv_attach_trace_probe("test_da_kunit", /* XXX: tracepoint */, handle_event_2);
> +
> +	return 0;
> +}
> +
> +static void disable_test_da_kunit(void)
> +{
> +	rv_this.enabled = 0;
> +
> +	rv_detach_trace_probe("test_da_kunit", /* XXX: tracepoint */, handle_event_1);
> +	rv_detach_trace_probe("test_da_kunit", /* XXX: tracepoint */, handle_event_2);
> +
> +	da_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_this = {
> +	.name = "test_da_kunit",
> +	.description = "auto-generated",
> +	.enable = enable_test_da_kunit,
> +	.disable = disable_test_da_kunit,
> +	.reset = da_monitor_reset_all,
> +	.enabled = 0,
> +};
> +
> +static int __init register_test_da_kunit(void)
> +{
> +	return rv_register_monitor(&rv_this, NULL);
> +}
> +
> +static void __exit unregister_test_da_kunit(void)
> +{
> +	rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_test_da_kunit);
> +module_exit(unregister_test_da_kunit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("rvgen: auto-generated");
> +MODULE_DESCRIPTION("test_da_kunit: auto-generated");
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +#include <kunit/visibility.h>
> +#include "test_da_kunit_kunit.h"
> +
> +const struct rv_test_da_kunit_ops rv_test_da_kunit_ops = {
> +	.mon = RV_MON_OPS_INIT(),
> +	.handle_event_1 = handle_event_1,
> +	.handle_event_2 = handle_event_2,
> +};
> +EXPORT_SYMBOL_IF_KUNIT(rv_test_da_kunit_ops);
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
> new file mode 100644
> index 000000000000..290a9454caa4
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Automatically generated C representation of test_da_kunit automaton
> + * For further information about this format, see kernel documentation:
> + *   Documentation/trace/rv/deterministic_automata.rst
> + */
> +
> +#define MONITOR_NAME test_da_kunit
> +
> +enum states_test_da_kunit {
> +	state_a_test_da_kunit,
> +	state_b_test_da_kunit,
> +	state_max_test_da_kunit,
> +};
> +
> +#define INVALID_STATE state_max_test_da_kunit
> +
> +enum events_test_da_kunit {
> +	event_1_test_da_kunit,
> +	event_2_test_da_kunit,
> +	event_max_test_da_kunit,
> +};
> +
> +struct automaton_test_da_kunit {
> +	char *state_names[state_max_test_da_kunit];
> +	char *event_names[event_max_test_da_kunit];
> +	unsigned char function[state_max_test_da_kunit][event_max_test_da_kunit];
> +	unsigned char initial_state;
> +	bool final_states[state_max_test_da_kunit];
> +};
> +
> +static const struct automaton_test_da_kunit automaton_test_da_kunit = {
> +	.state_names = {
> +		"state_a",
> +		"state_b",
> +	},
> +	.event_names = {
> +		"event_1",
> +		"event_2",
> +	},
> +	.function = {
> +		{       state_b_test_da_kunit,       state_a_test_da_kunit },
> +		{               INVALID_STATE,       state_a_test_da_kunit },
> +	},
> +	.initial_state = state_a_test_da_kunit,
> +	.final_states = { 1, 0 },
> +};
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.c b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.c
> new file mode 100644
> index 000000000000..17826a5c47c8
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +/*
> + * XXX: include required headers, e.g.,
> + * #include <linux/sched.h>
> + */
> +#include "test_da_kunit_kunit.h"
> +
> +#if IS_REACHABLE(CONFIG_RV_MON_TEST_DA_KUNIT)
> +
> +static void rv_test_test_da_kunit(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx = test->priv;
> +	/*
> +	 * If you need to create task_structs with rv_kunit_alloc_mock_task()
> +	 * do it BEFORE preparing the test.
> +	 */
> +
> +	prepare_test(test, &rv_test_da_kunit_ops.mon);
> +
> +	/*
> +	 * XXX: write the test here
> +	 * e.g.
> +	 * RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
> +	 *	rv_test_da_kunit_ops.handle_event(args);
> +	 */
> +}
> +
> +#else
> +#define rv_test_test_da_kunit rv_test_stub
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.h b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.h
> new file mode 100644
> index 000000000000..0094215ff4fb
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Automatically generated by rvgen kunit.
> + * May need manual intervention for function prototypes that couldn't be
> + * found (e.g. are in another file) or variables to be exported.
> + */
> +
> +#ifndef __TEST_DA_KUNIT_KUNIT_H
> +#define __TEST_DA_KUNIT_KUNIT_H
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +
> +extern const struct rv_test_da_kunit_ops {
> +	struct rv_kunit_mon mon;
> +	void (*handle_event_1)(void *data, /* XXX: fill header */);
> +	void (*handle_event_2)(void *data, /* XXX: fill header */);
> +} rv_test_da_kunit_ops;
> +#endif
> +
> +#endif /* __TEST_DA_KUNIT_KUNIT_H */
> diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
> new file mode 100644
> index 000000000000..16804a79e834
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_TEST_DA_KUNIT
> +DEFINE_EVENT(event_da_monitor, event_test_da_kunit,
> +	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
> +	     TP_ARGS(state, event, next_state, final_state));
> +
> +DEFINE_EVENT(error_da_monitor, error_test_da_kunit,
> +	     TP_PROTO(char *state, char *event),
> +	     TP_ARGS(state, event));
> +#endif /* CONFIG_RV_MON_TEST_DA_KUNIT */
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/Kconfig b/tools/verification/rvgen/tests/golden/test_ha_kunit/Kconfig
> new file mode 100644
> index 000000000000..6c48770ace1a
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TEST_HA_KUNIT
> +	depends on RV
> +	# XXX: add dependencies if there
> +	select HA_MON_EVENTS_ID
> +	bool "test_ha_kunit monitor"
> +	help
> +	  auto-generated
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
> new file mode 100644
> index 000000000000..99d6244c2539
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "test_ha_kunit"
> +
> +/*
> + * XXX: include required tracepoint headers, e.g.,
> + * #include <trace/events/sched.h>
> + */
> +#include <rv_trace.h>
> +
> +/*
> + * This is the self-generated part of the monitor. Generally, there is no need
> + * to touch this section.
> + */
> +#define RV_MON_TYPE RV_MON_PER_TASK
> +/* XXX: If the monitor has several instances, consider HA_TIMER_WHEEL */
> +#define HA_TIMER_TYPE HA_TIMER_HRTIMER
> +#include "test_ha_kunit.h"
> +#include <rv/ha_monitor.h>
> +
> +/*
> + * This is the instrumentation part of the monitor.
> + *
> + * This is the section where manual work is required. Here the kernel events
> + * are translated into model's event.
> + *
> + */
> +#define BAR_NS(ha_mon) /* XXX: what is BAR_NS(ha_mon)? */
> +
> +#define FOO_NS /* XXX: what is FOO_NS? */
> +
> +static inline u64 bar_ns(struct ha_monitor *ha_mon)
> +{
> +	return /* XXX: what is bar_ns(ha_mon)? */;
> +}
> +
> +static u64 foo_ns = /* XXX: default value */;
> +module_param(foo_ns, ullong, 0644);
> +
> +/*
> + * These functions define how to read and reset the environment variable.
> + *
> + * Common environment variables like ns-based and jiffy-based clocks have
> + * pre-define getters and resetters you can use. The parser can infer the type
> + * of the environment variable if you supply a measure unit in the constraint.
> + * If you define your own functions, make sure to add appropriate memory
> + * barriers if required.
> + * Some environment variables don't require a storage as they read a system
> + * state (e.g. preemption count). Those variables are never reset, so we don't
> + * define a reset function on monitors only relying on this type of variables.
> + */
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_test_ha_kunit env, u64 time_ns)
> +{
> +	if (env == clk_test_ha_kunit)
> +		return ha_get_clk_ns(ha_mon, env, time_ns);
> +	else if (env == env1_test_ha_kunit)
> +		return /* XXX: how do I read env1? */
> +	else if (env == env2_test_ha_kunit)
> +		return /* XXX: how do I read env2? */
> +	return ENV_INVALID_VALUE;
> +}
> +
> +static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_test_ha_kunit env, u64 time_ns)
> +{
> +	if (env == clk_test_ha_kunit)
> +		ha_reset_clk_ns(ha_mon, env, time_ns);
> +}
> +
> +/*
> + * These functions are used to validate state transitions.
> + *
> + * They are generated by parsing the model, there is usually no need to change them.
> + * If the monitor requires a timer, there are functions responsible to arm it when
> + * the next state has a constraint, cancel it in any other case and to check
> + * that it didn't expire before the callback run. Transitions to the same state
> + * without a reset never affect timers.
> + * Due to the different representations between invariants and guards, there is
> + * a function to convert it in case invariants or guards are reachable from
> + * another invariant without reset. Those are not present if not required in
> + * the model. This is all automatic but is worth checking because it may show
> + * errors in the model (e.g. missing resets).
> + */
> +static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> +					enum states curr_state, enum events event,
> +					enum states next_state, u64 time_ns)
> +{
> +	if (curr_state == S0_test_ha_kunit)
> +		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns);
> +	else if (curr_state == S2_test_ha_kunit)
> +		return ha_check_invariant_ns(ha_mon, clk_test_ha_kunit, time_ns);
> +	return true;
> +}
> +
> +static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
> +					enum states curr_state, enum events event,
> +					enum states next_state, u64 time_ns)
> +{
> +	if (curr_state == next_state)
> +		return;
> +	if (curr_state == S2_test_ha_kunit)
> +		ha_inv_to_guard(ha_mon, clk_test_ha_kunit, BAR_NS(ha_mon), time_ns);
> +}
> +
> +static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> +				    enum states curr_state, enum events event,
> +				    enum states next_state, u64 time_ns)
> +{
> +	bool res = true;
> +
> +	if (curr_state == S0_test_ha_kunit && event == event0_test_ha_kunit)
> +		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
> +	else if (curr_state == S0_test_ha_kunit && event == event1_test_ha_kunit)
> +		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
> +	else if (curr_state == S1_test_ha_kunit && event == event0_test_ha_kunit)
> +		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
> +	else if (curr_state == S1_test_ha_kunit && event == event2_test_ha_kunit) {
> +		res = ha_get_env(ha_mon, env1_test_ha_kunit, time_ns) == 0ull;
> +		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
> +	} else if (curr_state == S2_test_ha_kunit && event == event1_test_ha_kunit)
> +		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
> +		      ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < foo_ns;
> +	else if (curr_state == S3_test_ha_kunit && event == event0_test_ha_kunit)
> +		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
> +		      (ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < FOO_NS &&
> +		      ha_get_env(ha_mon, env2_test_ha_kunit, time_ns) == 0ull);
> +	else if (curr_state == S3_test_ha_kunit && event == event1_test_ha_kunit) {
> +		res = ha_monitor_env_invalid(ha_mon, clk_test_ha_kunit) ||
> +		      (ha_get_env(ha_mon, clk_test_ha_kunit, time_ns) < 5000ull &&
> +		      ha_get_env(ha_mon, env1_test_ha_kunit, time_ns) == 1ull);
> +		ha_reset_env(ha_mon, clk_test_ha_kunit, time_ns);
> +	}
> +	return res;
> +}
> +
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +				       enum states curr_state, enum events event,
> +				       enum states next_state, u64 time_ns)
> +{
> +	if (next_state == curr_state && event != event0_test_ha_kunit)
> +		return;
> +	if (next_state == S0_test_ha_kunit)
> +		ha_start_timer_ns(ha_mon, clk_test_ha_kunit, bar_ns(ha_mon), time_ns);
> +	else if (next_state == S2_test_ha_kunit)
> +		ha_start_timer_ns(ha_mon, clk_test_ha_kunit, BAR_NS(ha_mon), time_ns);
> +	else if (curr_state == S0_test_ha_kunit)
> +		ha_cancel_timer(ha_mon);
> +	else if (curr_state == S2_test_ha_kunit)
> +		ha_cancel_timer(ha_mon);
> +}
> +
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +				 enum states curr_state, enum events event,
> +				 enum states next_state, u64 time_ns)
> +{
> +	if (!ha_verify_invariants(ha_mon, curr_state, event, next_state, time_ns))
> +		return false;
> +
> +	ha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);
> +
> +	if (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))
> +		return false;
> +
> +	ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
> +
> +	return true;
> +}
> +
> +static void handle_event0(void *data, /* XXX: fill header */)
> +{
> +	/* XXX: validate that this event always leads to the initial state */
> +	struct task_struct *p = /* XXX: how do I get p? */;
> +	da_handle_start_event(p, event0_test_ha_kunit);
> +}
> +
> +static void handle_event1(void *data, /* XXX: fill header */)
> +{
> +	struct task_struct *p = /* XXX: how do I get p? */;
> +	da_handle_event(p, event1_test_ha_kunit);
> +}
> +
> +static void handle_event2(void *data, /* XXX: fill header */)
> +{
> +	struct task_struct *p = /* XXX: how do I get p? */;
> +	da_handle_event(p, event2_test_ha_kunit);
> +}
> +
> +static int enable_test_ha_kunit(void)
> +{
> +	int retval;
> +
> +	retval = ha_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event0);
> +	rv_attach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event1);
> +	rv_attach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event2);
> +
> +	return 0;
> +}
> +
> +static void disable_test_ha_kunit(void)
> +{
> +	rv_this.enabled = 0;
> +
> +	rv_detach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event0);
> +	rv_detach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event1);
> +	rv_detach_trace_probe("test_ha_kunit", /* XXX: tracepoint */, handle_event2);
> +
> +	ha_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_this = {
> +	.name = "test_ha_kunit",
> +	.description = "auto-generated",
> +	.enable = enable_test_ha_kunit,
> +	.disable = disable_test_ha_kunit,
> +	.reset = da_monitor_reset_all,
> +	.enabled = 0,
> +};
> +
> +static int __init register_test_ha_kunit(void)
> +{
> +	return rv_register_monitor(&rv_this, NULL);
> +}
> +
> +static void __exit unregister_test_ha_kunit(void)
> +{
> +	rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_test_ha_kunit);
> +module_exit(unregister_test_ha_kunit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("rvgen: auto-generated");
> +MODULE_DESCRIPTION("test_ha_kunit: auto-generated");
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +#include <kunit/visibility.h>
> +#include "test_ha_kunit_kunit.h"
> +
> +const struct rv_test_ha_kunit_ops rv_test_ha_kunit_ops = {
> +	.mon = RV_MON_OPS_INIT(),
> +	.handle_event0 = handle_event0,
> +	.handle_event1 = handle_event1,
> +	.handle_event2 = handle_event2,
> +};
> +EXPORT_SYMBOL_IF_KUNIT(rv_test_ha_kunit_ops);
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
> new file mode 100644
> index 000000000000..5c428f818bdf
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Automatically generated C representation of test_ha_kunit automaton
> + * For further information about this format, see kernel documentation:
> + *   Documentation/trace/rv/deterministic_automata.rst
> + */
> +
> +#define MONITOR_NAME test_ha_kunit
> +
> +enum states_test_ha_kunit {
> +	S0_test_ha_kunit,
> +	S1_test_ha_kunit,
> +	S2_test_ha_kunit,
> +	S3_test_ha_kunit,
> +	state_max_test_ha_kunit,
> +};
> +
> +#define INVALID_STATE state_max_test_ha_kunit
> +
> +enum events_test_ha_kunit {
> +	event0_test_ha_kunit,
> +	event1_test_ha_kunit,
> +	event2_test_ha_kunit,
> +	event_max_test_ha_kunit,
> +};
> +
> +enum envs_test_ha_kunit {
> +	clk_test_ha_kunit,
> +	env1_test_ha_kunit,
> +	env2_test_ha_kunit,
> +	env_max_test_ha_kunit,
> +	env_max_stored_test_ha_kunit = env1_test_ha_kunit,
> +};
> +
> +_Static_assert(env_max_stored_test_ha_kunit <= MAX_HA_ENV_LEN, "Not enough slots");
> +#define HA_CLK_NS
> +
> +struct automaton_test_ha_kunit {
> +	char *state_names[state_max_test_ha_kunit];
> +	char *event_names[event_max_test_ha_kunit];
> +	char *env_names[env_max_test_ha_kunit];
> +	unsigned char function[state_max_test_ha_kunit][event_max_test_ha_kunit];
> +	unsigned char initial_state;
> +	bool final_states[state_max_test_ha_kunit];
> +};
> +
> +static const struct automaton_test_ha_kunit automaton_test_ha_kunit = {
> +	.state_names = {
> +		"S0",
> +		"S1",
> +		"S2",
> +		"S3",
> +	},
> +	.event_names = {
> +		"event0",
> +		"event1",
> +		"event2",
> +	},
> +	.env_names = {
> +		"clk",
> +		"env1",
> +		"env2",
> +	},
> +	.function = {
> +		{
> +			S0_test_ha_kunit,
> +			S1_test_ha_kunit,
> +			INVALID_STATE,
> +		},
> +		{
> +			S0_test_ha_kunit,
> +			INVALID_STATE,
> +			S2_test_ha_kunit,
> +		},
> +		{
> +			INVALID_STATE,
> +			S2_test_ha_kunit,
> +			S3_test_ha_kunit,
> +		},
> +		{
> +			S0_test_ha_kunit,
> +			S1_test_ha_kunit,
> +			INVALID_STATE,
> +		},
> +	},
> +	.initial_state = S0_test_ha_kunit,
> +	.final_states = { 1, 0, 0, 0 },
> +};
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.c b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.c
> new file mode 100644
> index 000000000000..6214a4aa6d25
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +/*
> + * XXX: include required headers, e.g.,
> + * #include <linux/sched.h>
> + */
> +#include "test_ha_kunit_kunit.h"
> +
> +#if IS_REACHABLE(CONFIG_RV_MON_TEST_HA_KUNIT)
> +
> +static void rv_test_test_ha_kunit(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx = test->priv;
> +	/*
> +	 * If you need to create task_structs with rv_kunit_alloc_mock_task()
> +	 * do it BEFORE preparing the test.
> +	 */
> +
> +	prepare_test(test, &rv_test_ha_kunit_ops.mon);
> +
> +	/*
> +	 * XXX: write the test here
> +	 * e.g.
> +	 * RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
> +	 *	rv_test_ha_kunit_ops.handle_event(args);
> +	 */
> +}
> +
> +#else
> +#define rv_test_test_ha_kunit rv_test_stub
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.h b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.h
> new file mode 100644
> index 000000000000..0b2030cb644a
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Automatically generated by rvgen kunit.
> + * May need manual intervention for function prototypes that couldn't be
> + * found (e.g. are in another file) or variables to be exported.
> + */
> +
> +#ifndef __TEST_HA_KUNIT_KUNIT_H
> +#define __TEST_HA_KUNIT_KUNIT_H
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +
> +extern const struct rv_test_ha_kunit_ops {
> +	struct rv_kunit_mon mon;
> +	void (*handle_event0)(void *data, /* XXX: fill header */);
> +	void (*handle_event1)(void *data, /* XXX: fill header */);
> +	void (*handle_event2)(void *data, /* XXX: fill header */);
> +} rv_test_ha_kunit_ops;
> +#endif
> +
> +#endif /* __TEST_HA_KUNIT_KUNIT_H */
> diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
> new file mode 100644
> index 000000000000..6c13ee0068d3
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_TEST_HA_KUNIT
> +DEFINE_EVENT(event_da_monitor_id, event_test_ha_kunit,
> +	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
> +	     TP_ARGS(id, state, event, next_state, final_state));
> +
> +DEFINE_EVENT(error_da_monitor_id, error_test_ha_kunit,
> +	     TP_PROTO(int id, char *state, char *event),
> +	     TP_ARGS(id, state, event));
> +
> +DEFINE_EVENT(error_env_da_monitor_id, error_env_test_ha_kunit,
> +	     TP_PROTO(int id, char *state, char *event, char *env),
> +	     TP_ARGS(id, state, event, env));
> +#endif /* CONFIG_RV_MON_TEST_HA_KUNIT */
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/Kconfig b/tools/verification/rvgen/tests/golden/test_ltl_kunit/Kconfig
> new file mode 100644
> index 000000000000..3e334c344261
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TEST_LTL_KUNIT
> +	depends on RV
> +	# XXX: add dependencies if there
> +	select LTL_MON_EVENTS_ID
> +	bool "test_ltl_kunit monitor"
> +	help
> +	  auto-generated
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.c b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.c
> new file mode 100644
> index 000000000000..c1d58ce435a8
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "test_ltl_kunit"
> +
> +/*
> + * XXX: include required tracepoint headers, e.g.,
> + * #include <trace/events/sched.h>
> + */
> +#include <rv_trace.h>
> +
> +
> +/*
> + * This is the self-generated part of the monitor. Generally, there is no need
> + * to touch this section.
> + */
> +#include "test_ltl_kunit.h"
> +#include <rv/ltl_monitor.h>
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +	/*
> +	 * This is called everytime the Buchi automaton is triggered.
> +	 *
> +	 * This function could be used to fetch the atomic propositions which
> +	 * are expensive to trace. It is possible only if the atomic proposition
> +	 * does not need to be updated at precise time.
> +	 *
> +	 * It is recommended to use tracepoints and ltl_atom_update() instead.
> +	 */
> +}
> +
> +static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
> +{
> +	/*
> +	 * This should initialize as many atomic propositions as possible.
> +	 *
> +	 * @task_creation indicates whether the task is being created. This is
> +	 * false if the task is already running before the monitor is enabled.
> +	 */
> +	ltl_atom_set(mon, LTL_EVENT_A, true/false);
> +	ltl_atom_set(mon, LTL_EVENT_B, true/false);
> +}
> +
> +/*
> + * This is the instrumentation part of the monitor.
> + *
> + * This is the section where manual work is required. Here the kernel events
> + * are translated into model's event.
> + */
> +static void handle_example_event(void *data, /* XXX: fill header */)
> +{
> +	ltl_atom_update(task, LTL_EVENT_A, true/false);
> +}
> +
> +static int enable_test_ltl_kunit(void)
> +{
> +	int retval;
> +
> +	retval = ltl_monitor_init();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */, handle_example_event);
> +
> +	return 0;
> +}
> +
> +static void disable_test_ltl_kunit(void)
> +{
> +	rv_detach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */, handle_example_event);
> +
> +	ltl_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_this = {
> +	.name = "test_ltl_kunit",
> +	.description = "auto-generated",
> +	.enable = enable_test_ltl_kunit,
> +	.disable = disable_test_ltl_kunit,
> +};
> +
> +static int __init register_test_ltl_kunit(void)
> +{
> +	return rv_register_monitor(&rv_this, NULL);
> +}
> +
> +static void __exit unregister_test_ltl_kunit(void)
> +{
> +	rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_test_ltl_kunit);
> +module_exit(unregister_test_ltl_kunit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("rvgen: auto-generated");
> +MODULE_DESCRIPTION("test_ltl_kunit: auto-generated");
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.h b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.h
> new file mode 100644
> index 000000000000..acc503b56e87
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * C implementation of Buchi automaton, automatically generated by
> + * tools/verification/rvgen from the linear temporal logic specification.
> + * For further information, see kernel documentation:
> + *   Documentation/trace/rv/linear_temporal_logic.rst
> + */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME test_ltl_kunit
> +
> +enum ltl_atom {
> +	LTL_EVENT_A,
> +	LTL_EVENT_B,
> +	LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +	static const char *const names[] = {
> +		"ev_a",
> +		"ev_b",
> +	};
> +
> +	return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +	S0,
> +	S1,
> +	S2,
> +	S3,
> +	S4,
> +	RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);
> +
> +static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +	bool event_b = test_bit(LTL_EVENT_B, mon->atoms);
> +	bool event_a = test_bit(LTL_EVENT_A, mon->atoms);
> +	bool val1 = !event_a;
> +
> +	if (val1)
> +		__set_bit(S0, mon->states);
> +	if (true)
> +		__set_bit(S1, mon->states);
> +	if (event_b)
> +		__set_bit(S4, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
> +{
> +	bool event_b = test_bit(LTL_EVENT_B, mon->atoms);
> +	bool event_a = test_bit(LTL_EVENT_A, mon->atoms);
> +	bool val1 = !event_a;
> +
> +	switch (state) {
> +	case S0:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S1:
> +		if (true)
> +			__set_bit(S1, next);
> +		if (true && val1)
> +			__set_bit(S2, next);
> +		if (event_b && val1)
> +			__set_bit(S3, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S2:
> +		if (true)
> +			__set_bit(S1, next);
> +		if (true && val1)
> +			__set_bit(S2, next);
> +		if (event_b && val1)
> +			__set_bit(S3, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S3:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	case S4:
> +		if (val1)
> +			__set_bit(S0, next);
> +		if (true)
> +			__set_bit(S1, next);
> +		if (event_b)
> +			__set_bit(S4, next);
> +		break;
> +	}
> +}
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.c b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.c
> new file mode 100644
> index 000000000000..37dab5dfdebc
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +/*
> + * XXX: include required headers, e.g.,
> + * #include <linux/sched.h>
> + */
> +#include "test_ltl_kunit_kunit.h"
> +
> +#if IS_REACHABLE(CONFIG_RV_MON_TEST_LTL_KUNIT)
> +
> +static void rv_test_test_ltl_kunit(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx = test->priv;
> +	/*
> +	 * If you need to create task_structs with rv_kunit_alloc_mock_task()
> +	 * do it BEFORE preparing the test.
> +	 */
> +
> +	prepare_test(test, &rv_test_ltl_kunit_ops.mon);
> +
> +	/*
> +	 * XXX: write the test here
> +	 * e.g.
> +	 * RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
> +	 *	rv_test_ltl_kunit_ops.handle_event(args);
> +	 */
> +}
> +
> +#else
> +#define rv_test_test_ltl_kunit rv_test_stub
> +#endif
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.h b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.h
> new file mode 100644
> index 000000000000..b2ca34be327f
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Automatically generated by rvgen kunit.
> + * May need manual intervention for function prototypes that couldn't be
> + * found (e.g. are in another file) or variables to be exported.
> + */
> +
> +#ifndef __TEST_LTL_KUNIT_KUNIT_H
> +#define __TEST_LTL_KUNIT_KUNIT_H
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +
> +#include <linux/rv.h>
> +#include <rv/kunit.h>
> +
> +extern const struct rv_test_ltl_kunit_ops {
> +	struct rv_kunit_mon mon;
> +	void (*handle_example_event)(void *data, /* XXX: fill header */);
> +} rv_test_ltl_kunit_ops;
> +#endif
> +
> +#endif /* __TEST_LTL_KUNIT_KUNIT_H */
> diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
> new file mode 100644
> index 000000000000..a054d5b2c0ea
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_TEST_LTL_KUNIT
> +DEFINE_EVENT(event_ltl_monitor_id, event_test_ltl_kunit,
> +	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
> +	     TP_ARGS(task, states, atoms, next));
> +DEFINE_EVENT(error_ltl_monitor_id, error_test_ltl_kunit,
> +	     TP_PROTO(struct task_struct *task),
> +	     TP_ARGS(task));
> +#endif /* CONFIG_RV_MON_TEST_LTL_KUNIT */
> diff --git a/tools/verification/rvgen/tests/rvgen_kunit.t b/tools/verification/rvgen/tests/rvgen_kunit.t
> new file mode 100644
> index 000000000000..d27d9175f562
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/rvgen_kunit.t
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +source ../tests/engine.sh
> +test_begin
> +
> +set_timeout 30s
> +
> +# Help tests
> +check "verify kunit subcommand help" \
> +	"$RVGEN kunit -h" 0 "model_name" "spec"
> +
> +check_and_compare_folder "KUnit generation with local lookup and test_da_kunit" \
> +	"$RVGEN monitor -c da -s tests/specs/test_da.dot -t per_cpu -n test_da_kunit && $RVGEN kunit -a -l -n test_da_kunit" \
> +	"test_da_kunit" "Now complete the test and add it to rv_monitors_test.c" "RV_MON_OPS_INIT"
> +
> +check_and_compare_folder "KUnit generation with local lookup and test_ha_kunit" \
> +	"$RVGEN monitor -c ha -s tests/specs/test_ha.dot -t per_task -n test_ha_kunit && $RVGEN kunit -a -l -n test_ha_kunit" \
> +	"test_ha_kunit" "Successfully created KUnit" "Append the following to"
> +
> +check_and_compare_folder "KUnit generation with local lookup and test_ltl_kunit" \
> +	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -n test_ltl_kunit && $RVGEN kunit -l -n test_ltl_kunit" \
> +	"test_ltl_kunit" "RV_MON_OPS_INIT"
> +
> +check_and_compare_folder "KUnit generation with backup file" \
> +	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -n test_bak_kunit && echo DUMMY > test_bak_kunit/test_bak_kunit_kunit.c && $RVGEN kunit -l -n test_bak_kunit" \
> +	"test_bak_kunit" "KUnit file(s) already exist.*backing up existing files"
> +
> +# Error handling tests
> +check "missing required model_name" \
> +	"$RVGEN kunit" 2 "the following arguments are required: -n/--model_name"
> +
> +check "non-existent model_name with auto_patch" \
> +	"$RVGEN kunit -a -n nonexistent" 1 \
> +	"Could not find monitor C file" "Traceback (most recent call last)"
> +
> +check "monitor without handlers" \
> +	"mkdir -p nohandler ; echo DUMMY > nohandler/nohandler.c ; $RVGEN kunit -l -n nohandler" 1 \
> +	"No handlers found" "Traceback (most recent call last)"
> +rm -rf nohandler
> +
> +test_end
> -- 
> 2.55.0
> 
> 
