Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040427;
	b=MNzDYSZ549TBn2hFuiR/KorTwKYzqfcEjRN1kKBQ80OdXvy8nF4q1gugSKWRkSNHn4nA
	 m212iqjIHFwsE+KJoBWVNkzNCyRuFr6F6XwbQ81DSNZmsC70/2Icv0V8K59LaeDjPZdyv
	 IdooIEJw2V36sRn4tGQzkdYVKSJkUKmz4MEtdmi+uzoGwuvA0WX6Qc6ONPtebfZoP2FJJ
	 pB21whKT4twzHW94DAzLyaU1mFw6NbZmoxratqTvaT4oF2nVJn/gUuGVAVJtVMpLlG23X
	 3eoEtckZAUPU0Jdrre2kZqAmm3BXhZpjUVWtqJjMA7Kr8N5OdBl7wCYu57cbyoUnFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OJxaheqxeUVoKzMMQ6XAg2x9SuTj/AkBf7fm4JR34PU=;
	b=RXoivWuRDeDK37ZaYiVwevZu7ZGpgPtG33iTLNS8TLAFJZGzujIObcfa1tmRJYYE4tAj
	 pp+aZKRHOnjJvOxZgCeL9G/1DHNtuoqwEUcRdasyWnHRTCE45ClOLBdVU5SJi4Fu0r/1t
	 qaywpQEeK2VFDGH1P85yYVMx2WkRT1e9nYzZYS+eBD3Lw4R0B6zmSa1SpWTYMf12CfBjG
	 Mt6+7f3D09TIBneshKZ9FUPobL9t1/SIxpihIJTl0OKjaNgpVGSQHQn780Id0mYFHYNbg
	 qE7nQ85hNynLJ95qpwnyqDVThViSJPeB+7hkmGizMRwHm+I+LVdMv8P7C6jGnGqCczg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0DMqf8Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B9606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0DMqf8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95B41F01825;
	Mon, 26 Oct 2026 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793040426;
	bh=OJxaheqxeUVoKzMMQ6XAg2x9SuTj/AkBf7fm4JR34PU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g0DMqf8Q6uH7ja+xdybbGUjdgs5TP9tvrHhxvfeeGBmFRE6PKJlReHW/oFuELhJ+B
	 KjkprUVZXw9K9MqWxKo/2cStutCT0TqFAMiVirU/hxG/8S1FGmvBpr2R9bRb5zoGbl
	 DReD6mXy/UCZSxEEhgkCcSJUZm488tmEaQduVyl++2Y8Mcqeb24sweGRA1HXtZGWuM
	 NSN4/v37OonVt9r+L2x3n7enkPTmvpW+xYTNogGyMechk5Rx6zL3KWukakz7owXmTu
	 WQQAsCT5tQT+KH316T2pk5Ntde95wrCx5nihPhdBVneBmfnySKxtNU80A1+BWcrhA4
	 Mz9LCugeKHgyA==
Message-ID: <sashiko-outbox-185638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] platform/x86/intel/ifs: Select CPUs from
 topology_cluster_cpumask() for simultaneous IFS tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-10-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-10-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:47:06 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] platform/x86/intel/ifs: build_cpugroup_mask() called before cpu_on=
line() check
--

commit 206d196a9743b86ac3f7ca97505586f73d04016c
Author: Jithu Joseph <jithu.joseph@intel.com>

platform/x86/intel/ifs: Select CPUs from topology_cluster_cpumask() for sim=
ultaneous IFS tests

This commit updates the intel_ifs driver to record the group of CPUs
tested simultaneously in ifsd->grp_cpumask using topology_cluster_cpumask()
and stop_cluster_cpuslocked() when ifsd->all_lp_join is set.

> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index c6a4d6dcccf1f..09e7a81e92204 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c

[ ... ]

> @@ -398,6 +407,24 @@ static void ifs_array_test_gen1(int cpu, struct devi=
ce *dev)
>  		ifsd->status =3D SCAN_TEST_PASS;
>  }
> =20
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
>   * Initiate per core test. It wakes up work queue threads on the target =
CPU and
>   * its sibling CPU. Once all sibling threads wake up, the scan test gets=
 executed and
> @@ -411,6 +438,7 @@ int do_core_test(int cpu, struct device *dev)
> =20
>  	/* Prevent CPUs from being taken offline during the scan test */
>  	cpus_read_lock();
> +	build_cpugroup_mask(dev, cpu);
> =20
>  	if (!cpu_online(cpu)) {
>  		dev_info(dev, "cannot test on the offline CPU %d\n", cpu);

[Severity: High]
Should build_cpugroup_mask(dev, cpu) be called after the !cpu_online(cpu)
check in do_core_test() rather than before it?

In drivers/platform/x86/intel/ifs/sysfs.c, run_test_store() only checks
that cpu < nr_cpu_ids before invoking do_core_test(cpu, dev):

drivers/platform/x86/intel/ifs/sysfs.c:run_test_store() {
	...
	rc =3D kstrtouint(buf, 0, &cpu);
	if (rc < 0 || cpu >=3D nr_cpu_ids)
		return -EINVAL;

	rc =3D mutex_lock_interruptible(&ifs_sem);
	if (rc)
		return rc;

	rc =3D do_core_test(cpu, dev);
	...
}

However, in arch/x86/kernel/smpboot.c, smp_prepare_cpus_common() only
allocates per_cpu(cpu_l2c_shared_map, cpu) for CPUs in cpu_possible_mask:

arch/x86/kernel/smpboot.c:smp_prepare_cpus_common() {
	...
	for_each_possible_cpu(cpu) {
		node =3D cpu_to_node(cpu);
		...
		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, cpu), GFP_KERNEL, no=
de);
	}
}

If userspace writes a CPU index that is less than nr_cpu_ids but not in
cpu_possible_mask (for example when CONFIG_FORCE_NR_CPUS=3Dy or when
cpu_possible_mask is sparse), calling build_cpugroup_mask() before
checking cpu_online(cpu) will invoke:

  build_cpugroup_mask()
    topology_cluster_cpumask(cpu)
      cpu_clustergroup_mask(cpu)
        cpu_l2c_shared_mask(cpu)
          per_cpu(cpu_l2c_shared_map, cpu)

Can this access an uninitialized per-CPU offset and dereference a NULL
cpumask_var_t pointer under CONFIG_CPUMASK_OFFSTACK=3Dy (or set a
non-possible CPU bit in ifsd->grp_cpumask when ifsd->all_lp_join is false,
which later sysfs readers in this series pass to
per_cpu_ptr(ifsd->result_ptr, lcpu))?

Additionally, when a valid possible CPU is offline, remove_siblinginfo()
clears cpu_l2c_shared_mask(cpu). If userspace attempts to run a test on an
offline CPU and do_core_test() returns -EINVAL, won't calling
build_cpugroup_mask() beforehand overwrite ifsd->grp_cpumask with an empty
mask (when ifsd->all_lp_join is true) or with the untested offline CPU
(when ifsd->all_lp_join is false), clobbering the previous test's CPU
group state exposed by cpus_ran_list, status_list, details_list, and
addnl_details_list added in the subsequent patches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D9
