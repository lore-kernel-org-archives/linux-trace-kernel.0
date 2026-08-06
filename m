Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1F42EED8;
	Thu,  6 Aug 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036399; cv=none; b=FUrAQspKUZ/GNn1l3l0I/ScacRXMQPqyBJrvdfS/PdG+N424TIOmk418eQMXlsSn6O00GH4QwdPnt46tpiBAB1RBzVaCCDMcfluTxvz3KcdE27sOEYfBJ3pPVcnoiLPar1PQP/XrMQ2nqlwuXwE+XBbSnTuKcRmdWknjVms0dXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036399; c=relaxed/simple;
	bh=q5uKfuQLoGtmdrRsn36ltCuoJ1Eo9bvxw7g7uBsegQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRdu3a5Ay8uMIeFn1c4vxIVEmavjJzTiZUFVRs1OYDMbfhYBuGhLjk1GzVbVn1hZhbLOITPLWPIpO4AQNiT1hslBfF21+5n0d6eESrWGmGaWbW5voQRg8f+X5jkyrNtjK/Kqw7mRWpz2g3jhyqHpZp7Jrc6sfNLTTzIjR+YK4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BC3461A0179;
	Thu,  6 Aug 2026 17:13:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id CC4AA20026;
	Thu,  6 Aug 2026 17:13:13 +0000 (UTC)
Date: Thu, 6 Aug 2026 13:13:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260806131314.771bfaea@gandalf.local.home>
In-Reply-To: <202608050839.Ip5dU0Jz-lkp@intel.com>
References: <20260701174829.67ab8a33@gandalf.local.home>
	<202608050839.Ip5dU0Jz-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 3zxu5catii7wwqom4cwgc78hmyihubya
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: CC4AA20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wntJ8eLTWdze1jVk+IAZAz1C3ntxvfDU=
X-HE-Tag: 1786036393-324928
X-HE-Meta: U2FsdGVkX1/rgBM+CLUsf9sxmKDuJo5inziZG8FyT956ybuU/wxkKtdKsjwuN6loKAowENvTchxhkRbEdbpilbQhc2k79pwiG5RtmbCVk75gDOpGchPH9BikICD75KL/R13ZLdazPxvb1bJo7KoYJ8Toj54MS0bCm8tRBA/6PJhpsDEgKcytiDYZdIHg5p6ylg/jq33OSszE9a6Hmvm0O4aqGNZAmnfQNzE8rvJiRwHqHBStkv8W6y0Oe3l6eZar28pZPQM5WLPDWKM6AM3hVcrXCcQ9DA14C2n1xYNi3bgSWGluvxnScTr6uG4iZF5g+BLUxvV9JQmGwCXJygzKG1ppZq5HlQn71yjm4ojabaJ3tEZFChwiQPBZhzWag4VTYV/Xs9aMMD9lXKlcYS7vU3wMiaScHAPxNL3rknYd4e+e/8Sqg7xAC7jwgk+1FDhMgdOySyo6ivt8y8BvBOTuC4d/BxgqEa27


Does the kernel test robot just keep on testing old versions of a patch?
Sashiko discovered this issue and I made a v2 with a fix a week ago:

  https://lore.kernel.org/all/20260727155459.202af38d@gandalf.local.home/

-- Steve


On Wed, 5 Aug 2026 08:21:33 +0200
kernel test robot <lkp@intel.com> wrote:

> Hi Steven,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on trace/for-next]
> [also build test WARNING on linus/master v7.2-rc6 next-20260804]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tra=
cing-Cleanup-event_enable_trigger_parse-by-using-__free/20260805-073956
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace=
 for-next
> patch link:    https://lore.kernel.org/r/20260701174829.67ab8a33%40gandal=
f.local.home
> patch subject: [PATCH] tracing: Cleanup event_enable_trigger_parse() by u=
sing __free()
> config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/202=
60805/202608050839.Ip5dU0Jz-lkp@intel.com/config)
> compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260805/202608050839.Ip5dU0Jz-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202608050839.Ip5dU0Jz-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from ./include/linux/file.h:13,
>                     from ./include/linux/kernel_read_file.h:5,
>                     from ./include/linux/security.h:26,
>                     from kernel/trace/trace_events_trigger.c:8:
>    kernel/trace/trace_events_trigger.c: In function 'event_enable_trigger=
_parse':
> >> ./include/linux/cleanup.h:228:22: warning: ignoring return value of '_=
_must_check_fn' declared with attribute 'warn_unused_result' [-Wunused-resu=
lt] =20
>      228 |         ((typeof(p)) __must_check_fn((__force const volatile v=
oid *)__get_and_null(p, NULL)))
>          |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_events_trigger.c:1842:9: note: in expansion of macr=
o 'no_free_ptr'
>     1842 |         no_free_ptr(enable_data);
>          |         ^~~~~~~~~~~
>=20
>=20
> vim +228 ./include/linux/cleanup.h
>=20
> 85be6d84244706 Peter Zijlstra 2023-08-15  226 =20
> 54da6a0924311c Peter Zijlstra 2023-05-26  227  #define no_free_ptr(p) \
> 366fef794bd2b7 Ilpo J=C3=A4rvinen  2025-03-10 @228  	((typeof(p)) __must_=
check_fn((__force const volatile void *)__get_and_null(p, NULL)))
> 54da6a0924311c Peter Zijlstra 2023-05-26  229 =20
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

