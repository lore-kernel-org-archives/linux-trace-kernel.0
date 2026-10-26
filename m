Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040559;
	b=x733EC+4wLeci6mkdM6Q/TUdgQmn9UJjaWUbkp3LsBOKBP8Egfd7AatVS2wJacC9EObR
	 dP3SiJlgg9Z8VhlrP5aH7jsdWNZ4lzmxI/TBkHciKviH7hBTmkzH3ZyKeizkt/KxVrCSX
	 ZHVgoAlifbZodYlZLIYwv0NEqgNAZ7sr+82OTQeFNZmiWbxnlt0t0c14pGd7doNHkrGca
	 HfTIz+IAQquYwHHPCcVYPuG6ycWXw47yAT34Syyi9fVQNeZjvAO6a6T7ndikg0sqE1otg
	 VnO1DXSuxkFcZC3DzAzvjPHrV5Crt6z+6l+Ph0QE9HGJhK83IYwN2lOEad0196zKA6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vtfda19zMsySYSqTq74kwt018ht5LkGB3Tp0jWWb8rA=;
	b=xAXNQKKBu/qd+PuJKY9ZevMiF7wfov0MMqhEy0LdpR8StCe2UM1EZFR1Hv5KiCHSq5Hk
	 6JY0tzMKQiWhKPTxyzTXO0eB11zadnpBHt4Hg4ZcDS6FO7SUh+cCvalrlISq/To/8tD20
	 UgpYDxhqdOVG5jFgL0Q49gmW8tV+5yAKlHURv9oEZ7kVw3rHa8lBJfdLJniyo9C0MDESj
	 H5lmlFV32yY3fgmjdZvrfuOUbAMWjHNrkjN9ptNZCxXMUVneOqyAWQYRQXIsGa3MU/YgC
	 OXS+7Y8XlYmEeEv3dzI4NjW+YfdsT3236hrxNc0SS7S73L09AM3ABw4y53Pu4nCwzfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggByWu2N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F5606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggByWu2N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EAE1F01825;
	Mon, 26 Oct 2026 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793040559;
	bh=Vtfda19zMsySYSqTq74kwt018ht5LkGB3Tp0jWWb8rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggByWu2NkbO6gdfmud6GrvgrYJe2TySkAcSMRPDCXzmhW0fgK+EeejT3fZOI0tTSo
	 gFUx79RMKxu7+36Ev7Ey+m71sNhL9AEv8EGJsJT5pZmhCapPXSoJADNc0DcwSooAwA
	 Xi3yxySTrT+ZMnrXaRjGMCIohvICv+bxn8YAGtG5kmMylgB5/Ve5znMOvZl3HwYFXp
	 IGAjTmKqnDUJycY8n45794fLGg3mb8AK/Q3tS18FXOfy3oH2CTzbjuFR15MR6+9htC
	 Z3fYNPAKBruXd2IcuK4/PG2/Ta2RoUgh+U5WhOd1UEuQtu2tSlB8BUcunI7/FNJCt5
	 og5S+NJF09tFA==
Message-ID: <sashiko-outbox-185641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] platform/x86/intel/ifs: Validate TID_BIT_SHIFT
 matches topology_cluster_cpumask()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-11-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-11-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:49:18 +0000
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
- [High] platform/x86/intel/ifs: ifs_init() fails on SAF_GEN=3D0 CPUs
- [Medium] platform/x86/intel/ifs: broken cluster validation in topology_cl=
uster_matched()
--

commit d52108059abf4fca7e3a463651949851cf65de59
Author: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

platform/x86/intel/ifs: Validate TID_BIT_SHIFT matches topology_cluster_cpu=
mask()

This commit validates during driver initialization that the logical
processors indicated by TID_BIT_SHIFT in MSR_INTEGRITY_CAPS match
topology_cluster_cpumask(), failing driver load if they do not match.

> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index f2d2caab04797..c830a02fe7b33 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
[ ... ]
> @@ -69,6 +71,45 @@ static struct ifs_device ifs_devices[] =3D {
>  	},
>  };
> =20
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

[Severity: Medium]
Can topology_cluster_matched() fail when CPUs in cluster 0 are offline or
undergoing hotplug during module initialization?

topology_cluster_cpumask(0) returns a pointer to per_cpu(cpu_l2c_shared_map,
0), which only tracks currently online CPUs and is updated in-place by
set_cpu_sibling_map() and remove_siblinginfo() under the CPU hotplug lock:

arch/x86/kernel/smpboot.c:remove_siblinginfo() {
	...
	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
	...
}

Because CONFIG_INTEL_IFS is tristate, ifs_init() can run at module load time
without holding cpus_read_lock(). topology_cluster_matched() iterates over
cpumask in for_each_cpu_andnot() to compute step and then re-reads cpumask
in cpumask_weight(cpumask) to compute cpus, so concurrent CPU hotplug on a
cluster-0 sibling can mutate the mask between the two reads.

Furthermore, if any CPU in cluster 0 is offline when the module is loaded
(for example, when a core or thread in a Dual-Core Module is offline, or
when booted with maxcpus=3D1), cpumask_weight(cpumask) and step will not
reflect the full hardware cluster, causing dist !=3D (1 << shift) and faili=
ng
driver initialization with -EINVAL.

In addition, when cpumask contains only CPU 0 (cpus =3D=3D 1), the fallback:

	if (!step)
		step =3D 2;

forces dist to 2, while when cpus >=3D 2, step >=3D 1 also makes dist >=3D =
2. Can
dist ever match (1 << shift) on a non-SMT single-CPU cluster where
TID_BIT_SHIFT is 0?

> +
>  #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
> =20
>  static void ifs_cleanup(void)
> @@ -122,6 +163,13 @@ static int __init ifs_init(void)
>  		 */
>  		ifs_devices[i].rw_data.all_lp_join =3D ifs_devices[i].rw_data.generati=
on ?
>  						(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
> +
> +		if (ifs_devices[i].rw_data.all_lp_join && !topology_cluster_matched(ms=
rval)) {
> +			pr_err_once("TID_BIT_SHIFT mismatched topology_cluster_cpumask().\n");
> +			ret =3D -EINVAL;
> +			goto err_exit;
> +		}

[Severity: High]
Won't this check cause ifs_init() to unconditionally fail with -EINVAL on
Sapphire Rapids and Emerald Rapids (SAF_GEN=3D0) processors?

On SAF_GEN=3D0 CPUs, ifs_devices[i].rw_data.generation is 0, so
ifs_devices[i].rw_data.all_lp_join is forced to true. However, bits 20:16
(TID_BIT_SHIFT) of MSR_INTEGRITY_CAPS were only introduced in SAF_GEN=3D2 a=
nd
read as 0 on SAF_GEN=3D0 platforms.

When ifs_init() calls topology_cluster_matched(msrval) with shift =3D=3D 0,
(1 << shift) is 1, whereas dist =3D step * cpus evaluates to 2 (both with
Hyper-Threading enabled where cpus =3D=3D 2 and step =3D=3D 1, and with
Hyper-Threading disabled where cpus =3D=3D 1 and step is forced to 2). As a
result, dist !=3D (1 << shift) is always true and topology_cluster_matched()
always returns false on SAF_GEN=3D0 hardware.

Should the topology_cluster_matched() check also be gated on
ifs_devices[i].rw_data.generation (or only performed when ALL_LP_JOIN is
enumerated by hardware)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D10
