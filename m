Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088568;
	b=ox/O+E8s1SKKkXRG4XqoR5FVuiI2pMBikQYc1h7pJAAabBuhbGt63Hv31IX3u6Xyt0zG
	 ZSqi1UDtktgXGfsnAEFDhZ4ZHVc5ez0TGfEOfxcgAdo32Fgh2V6tRO6cUsPuGL5Vuopgm
	 FrkPCUTAVfRAuwrgCYw2iY7P5F/0BmEFCsatqKOhcm0BTje4wPBy/v2eFxdEmLClW1erD
	 Ki0iku7tA79NaqnpAoFfWEaMqi9z6d40fzRvfl7pO/qMa75ow3r6yqG/X6POxG1hvUFfx
	 ockSIufO6eEpQugHyvh4vMQ2QCk1QPY20Z08u24FoVHmBNN5nN8OhsfnR5DOK0cRu6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088568;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=jmtkvhAEYg31NrvxTP/HzylVWf6dkN8MjnHFiVQwpWI=;
	b=CQ03hx0Pq2D3j/dORgeSft9d/mTWDvDf/UAJAeO1os94Y2idLPF3aRk5kJ+MtCIs67gx
	 +Jv9uoMJOaHwQcIrYec+Z4iz+9uPkt0f+416uDiWUFugSRDfBYe4hBrF93RkKXPE6CNqE
	 b0ljIlSjDVrSeq/+HCbe6OK7ZhIs9PtxLBjs0BI6WD8L3fefUYC7ZlsJzzVPfwF9bWI74
	 n7quDNoH47Ox2F0UTl/6rJxQCglfGP3NcDupd2iTF7CI3qQE5P65xaq8x26JGee3uqMj2
	 9HaV2PGgcmBJZ3OTGFhVKj66VGO4T6jqkffvZXKkNKX/wXZTuaLq9IiDPCc82688peA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCyzu+K3;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8C606A326;
	Thu, 19 Nov 2026 11:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCyzu+K3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795088568; x=1826624568;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KKx5C5TUttKPpQ25G6NdTpGsohk9kPbZ5RdWGoTyHhk=;
  b=gCyzu+K3i4c4dCqYBh4VvA3JCtsG5bbrxNNifZdoPungXK3QtaKxYVjY
   V5T/BEq6FSKlhFZJdhJKBXPb08MWUMNOfox4Koa2C/OeEksCLHj0cs/Y2
   xNVpbqZ1pFx+REdS1w6pkTAAhBXXcxRiI2RiHcWmmjm1O5v/Ahj8Gu9MV
   VTkgsgonviBJarRhD6tEBAKkDDovbt9aUZxuwNogBphaPHdegW4+P2TNK
   0CKUW4jUPJl2bBY7+bCTtT6i6zIRULgSba+W3MNWlragDFV5ym2Mzxduj
   /6TYgknKZ5Kmeqs6qDwY7LBIGas7cWFCO4rUsFahMds28EOWfL7cbbaZD
   g==;
X-CSE-ConnectionGUID: smWGuINQR0CLriaTRdFirg==
X-CSE-MsgGUID: iZMpj4pHSBiCobeSj8/CaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3960381"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3960381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:42:47 -0800
X-CSE-ConnectionGUID: n/BdXH7HRH6D8VP/fKb5Pw==
X-CSE-MsgGUID: otHe7BjUQFOhgadYkikTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10323989"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:42:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 13:42:37 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 10/17] platform/x86/intel/ifs: Warn if a group test
 fails with CPUs missing
In-Reply-To: <20261118193259.519568-11-ehab.ababneh@intel.com>
Message-ID: <039913bc-ab42-bea2-1af6-c2aa6f92aa7b@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-11-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-642084259-1795088557=:1599"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-642084259-1795088557=:1599
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 18 Nov 2026, Ehab Ababneh wrote:

> All the logical processors that share a SCAN test engine must join a
> group test. TID_BIT_SHIFT [1] gives the number of low APIC ID bits that
> tell these logical processors apart. The driver builds the group from
> topology_cluster_cpumask(), which only holds CPUs that are enumerated
> and online. So it cannot tell whether every logical processor sharing
> the engine actually takes part, for example on a part that exposes only
> one core per module, or when a sibling has been taken offline.
>=20
> Checking this once at driver load does not help: the group can change
> at runtime through CPU hotplug, and failing to load would stop parts
> that may still test fine. Instead, read TID_BIT_SHIFT at init and, when
> a test does not pass, check whether all logical processors in the
> CPU's TID_BIT_SHIFT APIC ID range were in the group. If not, say so in
> the log. The test is run either way.
>=20
> TID_BIT_SHIFT is only enumerated starting with SAF_GEN=3D2 (Granite
> Rapids), so skip the check on SAF_GEN=3D0 parts (Sapphire Rapids and
> Emerald Rapids).
>=20
> [1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel=C2=AE Xeon=
=C2=AE
>     6 P-Core Processors" in the Intel Software Developers' Manual,
>     March 2025.
>=20
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h         |  1 +
>  drivers/platform/x86/intel/ifs/core.c    |  6 +++++
>  drivers/platform/x86/intel/ifs/ifs.h     |  2 ++
>  drivers/platform/x86/intel/ifs/runtest.c | 30 ++++++++++++++++++++++++
>  4 files changed, 39 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 9224b55e1f07..baa16d75749d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -283,6 +283,7 @@
>  #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT=094
>  #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST=09=09BIT(MSR_INTEGRITY_CAP=
S_PERIODIC_SCAN_BIST_BIT)
>  #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK=09=09=09GENMASK_ULL(10, 9)
> +#define MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK=09=09GENMASK_ULL(20, 16)
>  #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT=09=0921
>  #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN=09=09=09BIT(MSR_INTEGRITY_CAPS_AL=
L_LP_JOIN_BIT)
> =20
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index f2d2caab0479..b9ac04228141 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -122,6 +122,12 @@ static int __init ifs_init(void)
>  =09=09 */
>  =09=09ifs_devices[i].rw_data.all_lp_join =3D ifs_devices[i].rw_data.gene=
ration ?
>  =09=09=09=09=09=09(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
> +
> +=09=09/* TID_BIT_SHIFT is only enumerated on SAF_GEN=3D2 and later */
> +=09=09if (ifs_devices[i].rw_data.generation)
> +=09=09=09ifs_devices[i].rw_data.tid_bit_shift =3D
> +=09=09=09=09FIELD_GET(MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK, msrval);
> +
>  =09=09ifs_devices[i].rw_data.array_gen =3D (u32)m->driver_data;
>  =09=09ret =3D misc_register(&ifs_devices[i].misc);
>  =09=09if (ret)
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index 365429fafe7a..62db0a6aa940 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -297,6 +297,7 @@ struct ifs_test_msrs {
>   * @chunk_size: size of a test chunk
>   * @array_gen: test generation of array test
>   * @all_lp_join: all logical processors join test
> + * @tid_bit_shift: APIC-ID bits of the logical processors sharing a scan=
 engine
>   */
>  struct ifs_data {
>  =09cpumask_t=09grp_cpumask;
> @@ -311,6 +312,7 @@ struct ifs_data {
>  =09u32=09chunk_size;
>  =09u32=09array_gen;
>  =09bool=09all_lp_join;
> +=09u8=09tid_bit_shift;
>  };
> =20
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index c618857cd620..783b29f234ba 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -425,6 +425,32 @@ static void build_cpugroup_mask(struct device *dev, =
int cpu)
>  =09cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
>  }
> =20
> +/*
> + * Check whether all logical processors that share the scan engine with =
@cpu
> + * (the TID_BIT_SHIFT APIC-ID range) are online and in the test group. I=
f not,
> + * the test is still attempted; it may pass if the microcode handles the
> + * missing logical processors, e.g. a module with only one core.
> + */
> +static bool ifs_group_incomplete(int cpu, struct ifs_data *ifsd)
> +{
> +=09u32 shift =3D ifsd->tid_bit_shift;
> +=09u32 engine =3D cpu_data(cpu).topo.apicid >> shift;
> +=09int i;
> +
> +=09if (!ifsd->generation || !ifsd->all_lp_join)
> +=09=09return false;
> +
> +=09if (cpumask_weight(&ifsd->grp_cpumask) !=3D 1U << shift)

BIT()

> +=09=09return true;
> +
> +=09for_each_cpu(i, &ifsd->grp_cpumask) {
> +=09=09if (cpu_data(i).topo.apicid >> shift !=3D engine)
> +=09=09=09return true;
> +=09}
> +
> +=09return false;
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target =
CPU and
>   * its sibling CPU. Once all sibling threads wake up, the scan test gets=
 executed and
> @@ -464,6 +490,10 @@ int do_core_test(int cpu, struct device *dev)
>  =09default:
>  =09=09ret =3D -EINVAL;
>  =09}
> +
> +=09if (!ret && ifsd->status !=3D SCAN_TEST_PASS && ifs_group_incomplete(=
cpu, ifsd))
> +=09=09dev_warn(dev, "CPU %d: test did not pass; not all CPUs sharing the=
 scan engine were found (group %*pbl)\n",
> +=09=09=09 cpu, cpumask_pr_args(&ifsd->grp_cpumask));

Add include.

Add braces to multiline constructs even if they're single statement.

>  out:
>  =09cpus_read_unlock();
>  =09return ret;
>=20

--=20
 i.

--8323328-642084259-1795088557=:1599--
