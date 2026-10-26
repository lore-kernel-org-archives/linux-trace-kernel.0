Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040873;
	b=Oh2EZM9Y6DV7IZq2JvuHxyC0U68sZndnoto/SL7DmWjxLy2XaqaOvinGnr7ovi9NWyxH
	 aB31cKx+POe6qCd+2sxRk+qnX3f6fEPxCrtXrw4ZrXGhLQLglvLrGyHildAl2Rgt1xHFd
	 YhxPEGBZeQ3OwaZ7UnZXkeQxBa7NseeNdFNpY8o3XKkKRR+CL1lzjbj9NYZ0A0uH9j431
	 3fSwDreU0C2vOz8AOL5Yt/9nx91TKpCNvVs+qRTcNkQOo2/8NDQjzRnUZH7Gwqore5/db
	 EWm5vsdfMu2Df10r6otDCwnC1jiZLZMwKLL8NUsOhDynpKQPpCPe74Rk9cOp+Vec6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zbWBVFUiv2txoUklvAgleZ7Y1GtcHyF3kXrMb/KvlQ0=;
	b=F0GlJfR8JHJSrSgUfwUbjP8dYw3/SR1CQtM2QhPTSVFHRXiijHoxYY26lupAKwBWmCe+
	 d5cTN70BmdOHihPN7rtimEozkPbBolRwRvG4YkSjOleCqfqduEm7q8hV/ZvbKFtASbdHC
	 9xLD3hduiyX2YrRAuNgk042nfx+7TUfXesKPLhh8Fsmp0qMjM3ZV0rZQWdOh84kO6NfOe
	 r2RlEZlSR9sCmARuC3K4J0+6349M9OJImAuedJE1ObPWS8+j4PCokheHA2Nzplb+s7eGG
	 3uKy5qSFYMJGoAWeO/pkt7efAQRYUapQc9iCJJRLjmmH5fiHfG2ufVpZ+9VtqoiiLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLUVYcol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A42606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLUVYcol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EFC1F01828;
	Mon, 26 Oct 2026 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793040872;
	bh=zbWBVFUiv2txoUklvAgleZ7Y1GtcHyF3kXrMb/KvlQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLUVYcolMsK7YxGeC8Vnc3M1CA4/URMiyrCfhbNXYB6JJNUegSiBfY2ckkxpmZ9qc
	 jUbUBZQ7WjESVYsm6fhn7ZMmwi/UOOlMS+IXiF+Tpv+AeeTWUlQq7QltvJoU0Bre/8
	 IF1s7/OcQRaUKwtfHrIx5k7lHhUVVOaWzDQbeLfcXk6u/SRUf+5kujuhfiRVhjS0z7
	 xvum9oXXUDAsEzvo6vOkMvELuPLQ3iXTI/5mogwBSBWKDJxUUYPxSvvLDOqMOdlN1z
	 8TZ79s48p/t7ZIGRVUvJmHtt2Ijymp8oUzURPrho7u4PYwGXiFeB2blfzHjoR9MfDy
	 n5w42gW3rGByQ==
Message-ID: <sashiko-outbox-185648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/17] Documentation/ABI: Update IFS ABI doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-18-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-18-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:54:32 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] platform/x86: intel/ifs: ifs_init() fails on gen0 due to cluster c=
heck
- [High] platform/x86: intel/ifs: do_core_test() updates grp_cpumask before=
 checks
--

commit d3afda8246f048aa9feb139ad53fbb292e1d53d9
Author: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Documentation/ABI: Update IFS ABI doc

This series updates the Intel In-Field Scan (IFS) driver to support CPU
clusters sharing a scan test engine, validates cluster topology against
MSR_INTEGRITY_CAPS, tracks per-CPU scan results, and adds sysfs list
interfaces along with their documentation.

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
Will ifs_init() -> topology_cluster_matched() cause a regression where driv=
er
initialization unconditionally fails with -EINVAL on all Sapphire Rapids and
Emerald Rapids (generation =3D=3D 0) processors?

In ifs_init(), when ifs_devices[i].rw_data.generation is 0, all_lp_join is
forced to true, and topology_cluster_matched() is then called without check=
ing
whether generation is non-zero.

On generation 0 platforms, bits [20:16] (MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_M=
ASK)
of MSR_INTEGRITY_CAPS are reserved and read as 0, so shift is 0 and (1 << s=
hift)
is 1. However, in topology_cluster_matched(), dist =3D step * cpus is alway=
s at
least 2 (when SMT is enabled, cpus >=3D 2 and step >=3D 1; when SMT is disa=
bled,
cpus =3D=3D 1 and step is set to 2). As a result, dist !=3D (1 << shift) al=
ways
evaluates to true and ifs_init() aborts with -EINVAL.

Additionally, on generation >=3D 2 systems, topology_cluster_matched() comp=
utes
cpus =3D cpumask_weight(topology_cluster_cpumask(0)) using only currently o=
nline
CPUs and assumes !step always means 2-way SMT disabled (step =3D 2). If any
sibling thread or core in CPU 0's cluster is offline when the module loads,
won't dist !=3D (1 << shift) also fail initialization?

> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index dfc119d7354d7..d5303dd722333 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c

[ ... ]

> +static void build_cpugroup_mask(struct device *dev, int cpu)
>  {
> -	union ifs_sbaf_status status =3D (union ifs_sbaf_status)status_data;
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> =20

[ ... ]

> +	cpumask_clear(&ifsd->grp_cpumask);
> =20
>  	/*
> -	 * This WRMSR will wait for other HT threads to also write
> -	 * to this MSR (at most for activate.delay cycles). Then it
> -	 * starts scan of each requested bundle. The core test happens
> -	 * during the "execution" of the WRMSR.
> +	 * Some CPUs, such as Sierra Forest and Clearwater Forest, have multipl=
e cores
> +	 * sharing the same SCAN test engine, but they don't require a rendezvo=
us.
>  	 */

[ ... ]

> +	if (!ifsd->all_lp_join) {
> +		cpumask_set_cpu(cpu, &ifsd->grp_cpumask);
> +		return;
>  	}
> =20

[ ... ]

> +	cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
>  }
> =20
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
Can calling build_cpugroup_mask() in do_core_test() before checking
cpu_online(cpu) and ifsd->loaded dereference a NULL cpumask pointer or corr=
upt
ifsd->grp_cpumask?

In drivers/platform/x86/intel/ifs/sysfs.c, run_test_store() only verifies
cpu < nr_cpu_ids before calling do_core_test(cpu, dev):

run_test_store()
  do_core_test(cpu, dev)
    build_cpugroup_mask(dev, cpu)

If user space writes a CPU number that is < nr_cpu_ids but not in
cpu_possible_mask:

1) When ifsd->all_lp_join is true, build_cpugroup_mask() calls
cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu)), which reads
per_cpu(cpu_l2c_shared_map, cpu). Because cpu_l2c_shared_map is only alloca=
ted
for possible CPUs in smp_prepare_cpus_common(), won't this dereference a NU=
LL
pointer when CONFIG_CPUMASK_OFFSTACK=3Dy?

2) When ifsd->all_lp_join is false, build_cpugroup_mask() sets the non-poss=
ible
CPU in ifsd->grp_cpumask before the !cpu_online(cpu) check returns -EINVAL.
Subsequent reads of status_list_show(), details_list_show(), and
addnl_details_list_show() in drivers/platform/x86/intel/ifs/sysfs.c will th=
en
iterate over ifsd->grp_cpumask and call per_cpu_ptr(ifsd->result_ptr, lcpu)=
 on
an unallocated per-CPU slot.

Even when cpu is possible, if cpu is offline (-EINVAL) or !ifsd->loaded (-E=
PERM
in the IFS_TYPE_SAF case), build_cpugroup_mask() has already overwritten
ifsd->grp_cpumask, causing cpus_ran_list, status_list, details_list, and
addnl_details_list to report stale or untested CPUs instead of "none" or the
previous test's group.

Should build_cpugroup_mask() be moved after the cpu_online(cpu) and
ifsd->loaded checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D17
