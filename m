Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041090;
	b=hr/RXoBN88pI0mT8/9l5pCeaoWoTJqQkmWy13pf06YdzmwmuhXl5gkAJ2b+1NxS0WX4m
	 4sGMZ0/wQ/fHYTC5d23GzRhPHFaFZqp5/Wl/oGDrn3E+syIX9O9dzXG4vygJtd0uSSXIP
	 PRnnlaTzrXaziDCHPqn+gjTFfJ2Ki7Y9euX3JU3esZDx1I0SwNusyr4vhRaR0LMwHrq7U
	 3SZmkd3hVqIPWq82uX2faAmj1sHuQy+AZcJ3CK5oPk1uCFMouL2ioZhGvFpf9yc4IvwsS
	 LimjwLwEoYYCrNRV6jdSu0Z4ARmM67j7FShemV7EhIFS6FctfUBbZuy8hpYdvPncHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041090;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iCqYNU4xu5ToYwPBNfPq2lntb1Axyl3OQE5N2DAv1Yc=;
	b=d0zPcNefwl+si3hDqSs54gIPTANUpthmzwzsJzsVhNoCjKpJAJbbzjET46QO28Cljf3U
	 xYp1+RZNoxSlasHVQHhWxONdrEy4EYDdN0B/qpyZMshSBeqnN/ZVMuuhFuoiVOBbnVFE7
	 vQJeXYFMIB3o9FtASJ2xpYTH3o5PM5jrUXRXr53sbV1McHZkhJ/7ToljQVbvx71nTgAey
	 LtPa+PrK1sHCZkHrFLm3NMSc+BOuAiKWa5hdv2RAwajh6qBdvs90GTbIzIHbvsKVCdpAN
	 Z+dyHmdySIzE2E+wGUbH1JCR7GcZuqCB0zoOySPRsP50OXpKAxjFhBquRfBRrl+kgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmYHQ+JI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A31606A324
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmYHQ+JI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0683C1F01828;
	Mon, 26 Oct 2026 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793041090;
	bh=iCqYNU4xu5ToYwPBNfPq2lntb1Axyl3OQE5N2DAv1Yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmYHQ+JIHet7OHZ2xMZM5yjY4Xm+ijFfkPO2lx6qEdgtoZRb3nGESmFYy1K6/V5SG
	 +NKILza3bQOk6AUzv2pY27Bopuxmuc7Ed0Ui/fljEkCtjg1iNmxiov5phE0P59a9fo
	 mHNRV7ChICXo+Rz4hTg+7NdPvGakxmigOMQ6lgdLCf80/745RLxH0ZSAu0vhwkQWMt
	 5HRZsjbfpb8XlvK2lCf39c2mQjXoNql/W12VCpitv/30narOOAJm1+YyjsTp82EdIj
	 R3sFKYk3iuNRoszbYheJiesoZMIenbhoDDDFBi0uxN8VxSL3NotsJMJu5hvCHTxofr
	 TV8QOpVn8vLIA==
Message-ID: <sashiko-outbox-185651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/17] platform/x86/intel/ifs: Update IFS documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-17-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-17-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:58:09 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] platform/x86/intel/ifs: ifs_init() fails on SAF_GEN=3D0 CPUs
- [High] platform/x86/intel/ifs: do_core_test() updates grp_cpumask before =
validation
- [Low] platform/x86/intel/ifs: fix documentation typo and inconsistencies =
in ifs.h
--

commit 00e0613f0da8feb277c2b0b17ada7d9df4902b12
Author: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

platform/x86/intel/ifs: Update IFS documentation

This series updates the Intel In-Field Scan (IFS) driver to support group-b=
ased
simultaneous testing using topology_cluster_cpumask(), validates TID_BIT_SH=
IFT
against the cluster topology, and adds per-group sysfs result attributes and
documentation.

> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index 3dafa28a10104..5c9c86e048371 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c

[ ... ]

> +/*
> + * Test whether logical processors indicated by TID_BIT_SHIFT that share=
 the
> + * same SCAN test engine match the cpumask from topology_cluster_cpumask=
().
> + */
> +static bool topology_cluster_matched(u32 msrval)
> +{
> +	u32 dist, shift =3D FIELD_GET(MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK, ms=
rval);
> +	const cpumask_t *cpumask =3D topology_cluster_cpumask(0);
> +	u32 delta, step =3D 0, first =3D cpu_data(0).topo.apicid;
> +	unsigned int cpu, cpus;
> +
> +	/* Get the minimal APIC ID step among the CPUs in the same cluster. */
> +	for_each_cpu_andnot(cpu, cpumask, cpumask_of(0)) {
> +		delta =3D abs(cpu_data(cpu).topo.apicid - first);
> +
> +		if (!step) {
> +			step =3D delta;
> +			continue;
> +		}
> +
> +		if (step > delta)
> +			step =3D delta;
> +	}
> +
> +	/* A Hyper-Threading (HT) system with HT disabled. */
> +	if (!step)
> +		step =3D 2;
> +
> +	cpus =3D cpumask_weight(cpumask);
> +	dist =3D step * cpus;
> +
> +	if (dist !=3D (1 << shift)) {
> +		pr_err_once("APICID step %u, group cpus %u, TID_BIT_SHIFT %u\n", step,=
 cpus, shift);
> +		return false;
> +	}
> +
> +	return true;
> +}

[ ... ]

> @@ -134,11 +157,33 @@ static int __init ifs_init(void)
>  			continue;
>  		ifs_devices[i].rw_data.generation =3D FIELD_GET(MSR_INTEGRITY_CAPS_SAF=
_GEN_MASK,
>  							      msrval);
> +		/*
> +		 * For Sapphire Rapids and Emerald Rapids (SAF_GEN=3D0), the ALL_LP_JO=
IN
> +		 * indicator is unavailable. However, all the threads within a core st=
ill
> +		 * need to run IFS simultaneously, so the variable 'all_lp_join' is
> +		 * forced to true.
> +		 *
> +		 * For Granite Rapids and later generations (SAF_GEN=3D2), the ALL_LP_=
JOIN
> +		 * indicator is available, the variable 'all_lp_join' is determined by
> +		 * this indicator.
> +		 */
> +		ifs_devices[i].rw_data.all_lp_join =3D ifs_devices[i].rw_data.generati=
on ?
> +						(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
> +
> +		if (ifs_devices[i].rw_data.all_lp_join && !topology_cluster_matched(ms=
rval)) {
> +			pr_err_once("TID_BIT_SHIFT mismatched topology_cluster_cpumask().\n");
> +			ret =3D -EINVAL;
> +			goto err_exit;
> +		}

[Severity: High]
Does this cause ifs_init() to fail with -EINVAL on all generation =3D=3D 0
platforms and on systems where any CPU in cluster 0 is offline at module lo=
ad
time?

In ifs_init(), when ifs_devices[i].rw_data.generation is 0 (such as on
Sapphire Rapids, Emerald Rapids, Sierra Forest, and Clearwater Forest),
all_lp_join is forced to true and topology_cluster_matched(msrval) is called
unconditionally.

However, TID_BIT_SHIFT (MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK) was only
introduced starting with Granite Rapids (generation =3D=3D 2) and is 0 on
generation =3D=3D 0 processors. In topology_cluster_matched():

    cpus =3D cpumask_weight(cpumask);
    dist =3D step * cpus;

    if (dist !=3D (1 << shift)) {
        ...
        return false;
    }

Because step is at least 1 when siblings are present (with cpus >=3D 2) or =
set
to 2 when !step (with cpus =3D=3D 1), dist is always >=3D 2, whereas (1 << =
shift)
is 1 when shift is 0. As a result, topology_cluster_matched() always returns
false on generation =3D=3D 0 CPUs, aborting driver initialization with -EIN=
VAL
(and on Sierra Forest and Clearwater Forest, forcing all_lp_join to true al=
so
causes build_cpugroup_mask() to use the 4-core L2 cluster mask instead of a
single core).

In addition, topology_cluster_matched() reads topology_cluster_cpumask(0)
without holding cpus_read_lock() and assumes all logical processors in
CPU 0's cluster are online. Since cpu_l2c_shared_map only tracks online CPU=
s,
if any sibling thread or core in cluster 0 is offline when the module loads
(for example, 3 of 4 CPUs online in a Dual-Core Module giving step =3D 1 and
cpus =3D 3, or only CPU 0 online giving step =3D 2 and cpus =3D 1 when shif=
t =3D 2),
dist !=3D (1 << shift) will also evaluate to true and fail initialization.

> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index f369fb0d3d82f..551202f86cea4 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -81,30 +81,52 @@
>   * The IFS driver provides sysfs interfaces via /sys/devices/virtual/mis=
c/intel_ifs_<n>/
>   * to control execution:
>   *
> - * Test a specific core::
> + * Test a specific group::
>   *
> - *   # echo <cpu#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
> + *   # echo <CPU#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
>   *
> - * when HT is enabled any of the sibling cpu# can be specified to test
> - * its corresponding physical core. Since the tests are per physical cor=
e,
> - * the result of testing any thread is same. All siblings must be online
> - * to run a core test. It is only necessary to test one thread.
> + * Any CPU in the same group that shares the same SCAN test engin can be
> + * specified to test its corresponding group. All CPUs in the same group
> + * must be online to run a group test. It is only necessary to test one
> + * CPU in the group.

[ ... ]

> + * More additional details of the last test for all CPUs in the same gro=
up are provided in /sys::
> + *
> + *   $ cat /sys/devices/virtual/misc/intel_ifs_0/addnl_details_list
> + *   0xc44191a 0xc44191a
>   *
>   * The details file reports the hex value of the test specific status MS=
R.
>   * Hardware defined error codes are documented in volume 4 of the Intel
> @@ -127,48 +149,22 @@
>   * 2) Hardware allows for some number of cores to be tested in parallel.
>   * The driver does not make use of this, it only tests one core at a tim=
e.

[Severity: Low]
This isn't a runtime bug, but there are a few small inconsistencies in the
documentation update in drivers/platform/x86/intel/ifs/ifs.h:

1. "shares the same SCAN test engin can be" has a typo ("engin" instead of
   "engine").

2. Under "Driver design choices", item 2 still says "it only tests one core
   at a time" rather than one group at a time.

3. The commit message refers to "{status, details, additional_details,
   cpus_ran}_list", whereas the sysfs attribute documented here and
   implemented in drivers/platform/x86/intel/ifs/sysfs.c is named
   addnl_details_list.

> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index a882cd42c191a..c57b9ed0b7be7 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c

[ ... ]

> +static void build_cpugroup_mask(struct device *dev, int cpu)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +
> +	cpumask_clear(&ifsd->grp_cpumask);
> +
> +	/*
> +	 * Some CPUs, such as Sierra Forest and Clearwater Forest, have multipl=
e cores
> +	 * sharing the same SCAN test engine, but they don't require a rendezvo=
us.
> +	 */
> +	if (!ifsd->all_lp_join) {
> +		cpumask_set_cpu(cpu, &ifsd->grp_cpumask);
> +		return;
> +	}
> +
> +	cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
> +}
> +
>  /*
> - * Initiate per core test. It wakes up work queue threads on the target =
cpu and
> - * its sibling cpu. Once all sibling threads wake up, the scan test gets=
 executed and
> + * Initiate per core test. It wakes up work queue threads on the target =
CPU and
> + * its sibling CPU. Once all sibling threads wake up, the scan test gets=
 executed and
>   * wait for all sibling threads to finish the scan test.
>   */
>  int do_core_test(int cpu, struct device *dev)
> @@ -628,9 +493,10 @@ int do_core_test(int cpu, struct device *dev)
> =20
>  	/* Prevent CPUs from being taken offline during the scan test */
>  	cpus_read_lock();
> +	build_cpugroup_mask(dev, cpu);
> =20
>  	if (!cpu_online(cpu)) {
> -		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
> +		dev_info(dev, "cannot test on the offline CPU %d\n", cpu);
>  		ret =3D -EINVAL;
>  		goto out;
>  	}

[Severity: High]
Should build_cpugroup_mask(dev, cpu) be called only after verifying that cpu
is online and that a test will actually be executed?

In run_test_store() -> do_core_test(), run_test_store() only checks
cpu >=3D nr_cpu_ids before calling do_core_test(cpu, dev), and do_core_test=
()
calls build_cpugroup_mask(dev, cpu) before checking !cpu_online(cpu) or
!ifsd->loaded:

1. When ifsd->all_lp_join is true, build_cpugroup_mask() calls:

       cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));

   which accesses per_cpu(cpu_l2c_shared_map, cpu). Because
   smp_prepare_cpus_common() only allocates cpu_l2c_shared_map for CPUs in
   cpu_possible_mask, writing a CPU number with cpu < nr_cpu_ids that is not
   in cpu_possible_mask when CONFIG_CPUMASK_OFFSTACK=3Dy will dereference a
   NULL cpumask pointer before the !cpu_online(cpu) check is reached.

2. If do_core_test() returns early with -EINVAL (because cpu is offline) or
   with -EPERM (because !ifsd->loaded for IFS_TYPE_SAF),
   build_cpugroup_mask() has already overwritten ifsd->grp_cpumask.
   Subsequent reads of cpus_ran_list, status_list, details_list, and
   addnl_details_list in drivers/platform/x86/intel/ifs/sysfs.c will then
   report the CPUs and stale per-CPU state of the rejected request instead
   of "none" or the last test that actually ran.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D16
