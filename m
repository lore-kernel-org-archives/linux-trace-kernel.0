Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088318;
	b=EIiyokRznWxziJngQJ/7tljPc/WFgs+IAgJPIAq3dowRqgR10fprr2wQ1X/QCxbmSGpu
	 5J+GLay5znByATD9dLzkB1khpE7rqEtTBX2eeBrZO5u6KSAfORlZBLwPbj5j+QJwo87Gy
	 D7yIDhHOEOH9CAdHU4sOZgdvcw1+Qh18F7pRuXNssyjZWqKlwSb+LNoZKrlFAU2gn9dAG
	 Zb2NFa6hW7dFrGfJT1ANpWbdBlJamhC8t1dQiU+LCqy4taCtV9FijmBR7YPf54pD+oDAa
	 yJpkzT3QiRnLNzb2vz22yfWfRbMxpA1JTcwZuJC4YNN0N4CVs2mkh2iQ8eQq9Lm9Rlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=4kzE2VWl/KRMb8VAsPniDrLSO+7tixDkbj+3EQ+m6PQ=;
	b=qwywQsSqe6Hs0pjWiO1TYDqsdBPlwlZtVxM1Zk06afBXS+Z1FdSVS/2ZEzxrH4eyiggl
	 xoPdC9iFM59/calphlApjXJx+18aa7YlnbXkti0qp4E+wi9xI8qHQhxfnH9zZorAA29tQ
	 ko6YtMp8obw5cj2Ic2yLF5rp/5ysDWfkAckLwQ46jvfD53r8qrGbuGYUDcRuD2S4AldtG
	 WOw1bGByCOL8Yh3SMta3LGGq7NkRAv74Lt/NOfNhUwAxKk3eI0DouP40UyZwfiXciPMSW
	 l6qBu+c7SHXwV1lHXghhCXMdVppIA8mf6BZ1jr6JGbh/CX3HunGJALosAdOoyBM2xtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Hr9OEV/F";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D606A32C;
	Thu, 19 Nov 2026 11:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D6D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hr9OEV/F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795088319; x=1826624319;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7mRi7YoPNsB3b882eqeBlP0fFM5VGoi4zJQeMy0mmyA=;
  b=Hr9OEV/FuH7pE6ueraaKmTlL3OEWDEJACA9iJiLm3+FW2ndH08lw/JJw
   53FvHNGS8BXmDLT0YO5IDVSaRUcy5+zFCC1j+vMrabBgmsMzv74vEGRij
   9JQXbXZ8nQnB2EsqSdmnNjj2WEpsKl0T5n2dvSBdyR+tE+/i+br5FpKMC
   Rwv/+nVUzsieZ7SJkjkrZ8ZLEdPzu+BjzZ7RGfavEusspqskKM6oUWA8Z
   pwVgXaiRPfirKaLWaxRqGInbBLhoHGHBRbVwEz9GKithc2j0bt2Re0I0T
   jA8D4D6WsbUpxto4y6nrVA2xr2Jvk89DqYjYoAAM84WSMjLnYougYRBiL
   w==;
X-CSE-ConnectionGUID: aebaDOjnSXiOLOM9BNlc1w==
X-CSE-MsgGUID: 4eLYor/FQ8auAnH0zYWChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3952634"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3952634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:38:38 -0800
X-CSE-ConnectionGUID: Modh2GXsQHGyNohCg90JEQ==
X-CSE-MsgGUID: tyKzxDM9TyqxY/RiNFnQlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10790017"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:38:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 13:38:27 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 09/17] platform/x86/intel/ifs: Select CPUs from
 topology_cluster_cpumask() for simultaneous IFS tests
In-Reply-To: <20261118193259.519568-10-ehab.ababneh@intel.com>
Message-ID: <1c3ebcd7-51f8-f5fa-3bcd-75b8f2644c60@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-10-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1423137071-1795088307=:1599"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1423137071-1795088307=:1599
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 18 Nov 2026, Ehab Ababneh wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
>=20
> The current intel_ifs driver selects CPUs from cpu_smt_mask() to run
> IFS test simultaneously. This approach works well for processors currentl=
y
> supported by the intel_ifs driver, where threads in a CPU core share the
> same SCAN test engine. However, it will not work for new Intel Xeon
> processors, such as Diamond Rapids, where multiple CPU cores in a module
> share the same SCAN test engine and must run IFS tests simultaneously.
>=20
> Starting with Granite Rapids (GNR) and later generations, bit[20:16]
> (TID_BIT_SHIFT) of MSR_INTEGRITY_CAPABILITIES register [1] contains the
> number of bits to shift right on x2APICID to obtain a unique topology ID
> for all logical processors that share a SCAN test engine. In theory,
> computing a cpumask by this method and using a stop_machine() variant
> with an arbitrary cpumask passed in to rendezvous CPUs for simultaneous
> IFS tests should work for both cases where threads in a core or CPU
> cores in a module share the same SCAN test engine. However, as per
> Tony Luck's feedback and the previous discussion [2], the Linux community
> is not in favor of a stop_machine() variant with an arbitrary cpumask.

I suggest using passive voice for what comes after ,

>=20
> Observations on existing Intel Xeon processors and the upcoming Diamond
> Rapids with IFS capability show that the logical processors sharing the
> same SCAN test engine are exactly the logical processors sharing the
> same L2 cache.
>=20
> topology_cluster_cpumask() returns the cpumask for CPUs sharing the same
> L2 cache. Therefore, select CPUs from topology_cluster_cpumask() to run
> IFS tests if simultaneous testing is required.
>=20
> [ Qiuxu: Re-wrote the commit message. ]

There's no Signed-off from Qiuxu ?

> [1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel=C2=AE Xeon=
=C2=AE
>     6 P-Core Processors" in the Intel Software Developers' Manual,
>     March 2025.
>=20
> [2] https://lore.kernel.org/all/20220505082824.GD2501@worktop.programming=
=2Ekicks-ass.net/

Move to Link: and add [2] to end.

>=20
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  2 +
>  drivers/platform/x86/intel/ifs/runtest.c | 54 ++++++++++++++++++------
>  2 files changed, 44 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index 814ebac10a5d..365429fafe7a 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -285,6 +285,7 @@ struct ifs_test_msrs {
> =20
>  /**
>   * struct ifs_data - attributes related to Intel IFS driver
> + * @grp_cpumask: set of CPUs being tested simultaneously
>   * @loaded_version: stores the currently loaded ifs image version.
>   * @loaded: If a valid test binary has been loaded into the memory
>   * @loading_error: Error occurred on another CPU while loading image
> @@ -298,6 +299,7 @@ struct ifs_test_msrs {
>   * @all_lp_join: all logical processors join test
>   */
>  struct ifs_data {
> +=09cpumask_t=09grp_cpumask;
>  =09int=09loaded_version;
>  =09bool=09loaded;
>  =09bool=09loading_error;
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index c6a4d6dcccf1..c618857cd620 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -156,11 +156,9 @@ static atomic_t scan_cpus_in;
>  /*
>   * Simplified CPU sibling rendezvous loop based on microcode loader wait=
_for_cpus()
>   */
> -static void wait_for_sibling_cpu(atomic_t *t, long long timeout)
> +static void wait_for_sibling_cpu(struct ifs_data *ifsd, atomic_t *t, lon=
g long timeout)
>  {
> -=09int cpu =3D smp_processor_id();
> -=09const struct cpumask *smt_mask =3D cpu_smt_mask(cpu);
> -=09int all_cpus =3D cpumask_weight(smt_mask);
> +=09int all_cpus =3D cpumask_weight(&ifsd->grp_cpumask);
> =20
>  =09atomic_inc(t);
>  =09while (atomic_read(t) < all_cpus) {
> @@ -195,9 +193,9 @@ static int doscan(void *data)
>  =09}
> =20
>  =09/* Only the first logical CPU on a core reports result */
> -=09first =3D cpumask_first(cpu_smt_mask(cpu));
> +=09first =3D cpumask_first(&ifsd->grp_cpumask);
> =20
> -=09wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
> +=09wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
> =20
>  =09/*
>  =09 * This WRMSR will wait for other HT threads to also write
> @@ -265,7 +263,11 @@ static void ifs_test_core(int cpu, struct device *de=
v)
> =20
>  =09=09params.activate =3D &activate;
>  =09=09atomic_set(&scan_cpus_in, 0);
> -=09=09stop_core_cpuslocked(cpu, doscan, &params);
> +
> +=09=09if (ifsd->all_lp_join)
> +=09=09=09stop_cluster_cpuslocked(cpu, doscan, &params);
> +=09=09else
> +=09=09=09stop_core_cpuslocked(cpu, doscan, &params);
> =20
>  =09=09status =3D params.status;
> =20
> @@ -310,15 +312,18 @@ static int do_array_test(void *data)
>  =09struct run_array_params *params =3D data;
>  =09int cpu =3D smp_processor_id();
>  =09union ifs_array *command;
> +=09struct ifs_data *ifsd;
>  =09int first;
> =20
> +=09ifsd =3D params->ifsd;
> +
>  =09command =3D params->command;
> -=09wait_for_sibling_cpu(&array_cpus_in, NSEC_PER_SEC);
> +=09wait_for_sibling_cpu(ifsd, &array_cpus_in, NSEC_PER_SEC);
> =20
>  =09/*
>  =09 * Only one logical CPU on a core needs to trigger the Array test via=
 MSR write.
>  =09 */
> -=09first =3D cpumask_first(cpu_smt_mask(cpu));
> +=09first =3D cpumask_first(&ifsd->grp_cpumask);
> =20
>  =09if (cpu =3D=3D first) {
>  =09=09wrmsrq(MSR_ARRAY_BIST, command->data);
> @@ -350,7 +355,11 @@ static void ifs_array_test_core(int cpu, struct devi=
ce *dev)
>  =09=09}
>  =09=09atomic_set(&array_cpus_in, 0);
>  =09=09params.command =3D &command;
> -=09=09stop_core_cpuslocked(cpu, do_array_test, &params);
> +
> +=09=09if (ifsd->all_lp_join)
> +=09=09=09stop_cluster_cpuslocked(cpu, do_array_test, &params);
> +=09=09else
> +=09=09=09stop_core_cpuslocked(cpu, do_array_test, &params);

Add a helper for this or should it just be a pointer (or add ops)?

> =20
>  =09=09if (command.ctrl_result)
>  =09=09=09break;
> @@ -398,6 +407,24 @@ static void ifs_array_test_gen1(int cpu, struct devi=
ce *dev)
>  =09=09ifsd->status =3D SCAN_TEST_PASS;
>  }
> =20
> +static void build_cpugroup_mask(struct device *dev, int cpu)
> +{
> +=09struct ifs_data *ifsd =3D ifs_get_data(dev);
> +
> +=09cpumask_clear(&ifsd->grp_cpumask);
> +
> +=09/*
> +=09 * Some CPUs, such as Sierra Forest and Clearwater Forest, have multi=
ple cores
> +=09 * sharing the same SCAN test engine, but they don't require a rendez=
vous.
> +=09 */
> +=09if (!ifsd->all_lp_join) {
> +=09=09cpumask_set_cpu(cpu, &ifsd->grp_cpumask);
> +=09=09return;
> +=09}
> +
> +=09cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target =
CPU and
>   * its sibling CPU. Once all sibling threads wake up, the scan test gets=
 executed and
> @@ -420,12 +447,15 @@ int do_core_test(int cpu, struct device *dev)
> =20
>  =09switch (test->test_num) {
>  =09case IFS_TYPE_SAF:
> -=09=09if (!ifsd->loaded)
> +=09=09if (!ifsd->loaded) {
>  =09=09=09ret =3D -EPERM;
> -=09=09else
> +=09=09} else {
> +=09=09=09build_cpugroup_mask(dev, cpu);
>  =09=09=09ifs_test_core(cpu, dev);
> +=09=09}
>  =09=09break;
>  =09case IFS_TYPE_ARRAY_BIST:
> +=09=09build_cpugroup_mask(dev, cpu);
>  =09=09if (ifsd->array_gen =3D=3D ARRAY_GEN0)
>  =09=09=09ifs_array_test_core(cpu, dev);
>  =09=09else
>=20

Unrelated to this patch, this function would be better of with using=20
guard() + simplied code flow it allows.

--=20
 i.

--8323328-1423137071-1795088307=:1599--
