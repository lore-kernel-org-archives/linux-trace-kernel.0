Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040560;
	b=tc7fA4oyd6HHOC0ybxDiSKWZHomsO0m414GdncraeinzGPtHwJMTXnyQ8GvTnMWNvGvT
	 IH1ScQh4b5wclBrPh/bd1s9tIqXXf9jiBpfYpuxnsuYIsvc4Kt6vam805BD7guBIucnb1
	 sM852pk/a4KsmVJ2IvHZWa11b7HYOi1Q61p8PGfFmhEAbOuQR1QZVMgMwO2OWoPsR3SQj
	 GYK1N9lR+5+XZPxMur4nQ68+x0Wqm9co5v1GgPWZE8+dKx0Stvys9deZLjinQq2M7o4Si
	 /NxXV1NWVjEc9fBO7T7EthZv3TCLricozikh+siMq1Ov4B5bSMK2yrpTA7/Op7ChX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040560;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uae77pp0DZ4YQzWYF3HWlZq1oF9TpK+qBtMgaSoopDo=;
	b=Lm4Alp0TgXfmjK6E9oaO0sV2jS3UkKYp/+HXgXw4L4QP8Zj1dxRqI9H17UwS/sEe9j5S
	 bvX39QT97Arc6yLv7TXL6PznobHnQ6DFPGs1fMQBVLv9rRZsvqxvUjjiBABr4R1C0+ssu
	 MPMs4WfGyGKLUIL7FWew3KQxBlFWFIZpjyxGec/5J7dUs8XvlKx1NdfZjGHMNJrd1HyFn
	 WqrPFpg4g+Lzy621ljigLChK2BoFX9xjIAeHSeK+xzz8B67bezaBAlZ4q9PAOMF0yW+6L
	 BNCh7PoTUKo69PTzCOEFiOso2mBIvc+o1WqfbVbe6dZ4pafAEcJ81K16MnVcnWRnPAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVzIWFxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EE606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVzIWFxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FBF1F01828;
	Mon, 26 Oct 2026 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793040559;
	bh=uae77pp0DZ4YQzWYF3HWlZq1oF9TpK+qBtMgaSoopDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVzIWFxo9Puz7R9/lsv1jsXlSLi3PG4razCU0zO2F+R01p2Fj3ZdgakKHuOAf4c8L
	 Ww+4qdMdTch8xgEdPxs0mkIBc36ndktwRfwjc14cla7cxgm1wzFaMjkFThfT6e4Duz
	 FBYeKzFhnyZPaKCuJpyj5GpUcYyqP82yqAd9PWrVsjiT1oeGU7WnaWTUQk4sxxPyXY
	 XyjI2qGddLMWaNiqwKMVOtdkssjzfC1kXXp00sTIFen77WkNJPEUykDAkrt17EzpkF
	 00behWll4Y267NSh9nT1QRvWM7sb5ZXjKdc6BHD6VFCMGDPinwz0Sh4bKbEHiq/+Fa
	 evNCcgCBedjUw==
Message-ID: <sashiko-outbox-185642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] platform/x86/intel/ifs: Add new sysfs interfaces
 {status, details, cpus_ran}_list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-13-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-13-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:49:19 +0000
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
- [High] platform/x86/intel/ifs: premature grp_cpumask update in do_core_te=
st()
- [Medium] platform/x86/intel/ifs: unlocked grp_cpumask reads in status_lis=
t_show()
--

commit bf9eae2e7ab2791a6f3b06b483c7daa541ce8c99
Author: Jithu Joseph <jithu.joseph@intel.com>

platform/x86/intel/ifs: Add new sysfs interfaces {status, details, cpus_ran=
}_list

This commit adds the status_list, details_list, and cpus_ran_list sysfs
attributes to report per-CPU scan statuses, details, and the group of CPUs
tested together during an In-Field Scan run.

> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x8=
6/intel/ifs/sysfs.c
> index 287f96bb033ea..82a603cd1fd34 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -135,6 +135,59 @@ static ssize_t image_version_show(struct device *dev,
> =20
>  static DEVICE_ATTR_RO(image_version);
> =20
> +static ssize_t status_list_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_state;
> +	int lcpu, len =3D 0;
> +
> +	if (cpumask_weight(&ifsd->grp_cpumask) =3D=3D 0)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_state =3D per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		len +=3D sysfs_emit_at(buf, len, "%s%s", (len > 0) ? " " : "",
> +				     status_msg[pcpu_state->test_result]);
> +	}
> +	len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}

[Severity: High]
Can status_list_show(), details_list_show(), and cpus_ran_list_show() report
bogus state or dereference invalid per-CPU pointers when a write to run_test
fails validation in do_core_test()?

In drivers/platform/x86/intel/ifs/runtest.c, run_test_store() only checks
cpu < nr_cpu_ids before calling do_core_test(), which unconditionally calls
build_cpugroup_mask() before checking cpu_online(cpu) and ifsd->loaded:

drivers/platform/x86/intel/ifs/runtest.c:do_core_test() {
	cpus_read_lock();
	build_cpugroup_mask(dev, cpu);

	if (!cpu_online(cpu)) {
		dev_info(dev, "cannot test on the offline CPU %d\n", cpu);
		ret =3D -EINVAL;
		goto out;
	}

	switch (test->test_num) {
	case IFS_TYPE_SAF:
		if (!ifsd->loaded)
			ret =3D -EPERM;
		else
			ifs_test_core(cpu, dev);
		break;
}

drivers/platform/x86/intel/ifs/runtest.c:build_cpugroup_mask() {
	cpumask_clear(&ifsd->grp_cpumask);
	...
	if (!ifsd->all_lp_join) {
		cpumask_set_cpu(cpu, &ifsd->grp_cpumask);
		return;
	}

	cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
}

When do_core_test() fails with -EPERM because !ifsd->loaded,
build_cpugroup_mask() has already populated ifsd->grp_cpumask. Reading
cpus_ran_list, status_list, and details_list afterwards reports that group =
as
having run (or overwrites the group mask from a prior valid test while lega=
cy
status and details keep the old results).

Similarly, when an offline or non-possible CPU < nr_cpu_ids is written to
run_test:
- If ifsd->all_lp_join is true and cpu is offline, topology_cluster_cpumask=
()
  is empty, wiping out ifsd->grp_cpumask from any previous valid test run.
- If ifsd->all_lp_join is true and cpu is not in cpu_possible_mask on a
  system with CONFIG_CPUMASK_OFFSTACK=3Dy, topology_cluster_cpumask(cpu) is
  NULL, causing a NULL pointer dereference in cpumask_copy().
- If ifsd->all_lp_join is false, build_cpugroup_mask() sets the offline or
  non-possible CPU in ifsd->grp_cpumask, causing status_list_show() and
  details_list_show() to dereference per_cpu_ptr(ifsd->result_ptr, lcpu) for
  that CPU.

Should do_core_test() validate cpu_online(cpu) and ifsd->loaded before
updating ifsd->grp_cpumask in build_cpugroup_mask()?

> +
> +static DEVICE_ATTR_RO(status_list);
> +
> +static ssize_t details_list_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_state;
> +	int lcpu, len =3D 0;
> +
> +	if (cpumask_weight(&ifsd->grp_cpumask) =3D=3D 0)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_state =3D per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		len +=3D sysfs_emit_at(buf, len, "%s%#llx", (len > 0) ? " " : "",
> +				     pcpu_state->test_details);
> +	}
> +	len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(details_list);
> +
> +static ssize_t cpus_ran_list_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +
> +	if (cpumask_weight(&ifsd->grp_cpumask) =3D=3D 0)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&ifsd->grp_cpumask));
> +}

[Severity: Medium]
Should status_list_show(), details_list_show(), and cpus_ran_list_show()
serialize with ifs_sem when reading ifsd->grp_cpumask and the per-CPU resul=
ts?

In run_test_store(), test execution is serialized under ifs_sem while
do_core_test() -> build_cpugroup_mask() clears and updates ifsd->grp_cpumask
and ifs_test_core() updates per-CPU test_details and test_result across chu=
nk
retries.

Because status_list_show(), details_list_show(), and cpus_ran_list_show() r=
ead
ifsd->grp_cpumask twice without holding ifs_sem (first in cpumask_weight() =
and
then in for_each_cpu() or cpumask_pr_args()), a concurrent
build_cpugroup_mask() clearing ifsd->grp_cpumask between the two reads caus=
es
these attributes to emit an empty line ("\n") instead of "none\n". In
addition, reading status_list or details_list while a test is in progress c=
an
pair the newly updated ifsd->grp_cpumask with stale test_result values from=
 a
previous run and intermediate per-chunk test_details.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D12
