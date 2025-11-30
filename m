Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FA2517B9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764524559; cv=none; b=oPVUiasXyH8Y6zq0nHCeFcNdU9YWpjionu6rl75/TNpkQtE56qR7FTyzXDe8JlDPnmOKOZa7P5rx6vslH6mVk3J6r/IqkhUoFVLVYRaK68RQq++vczkOCeyJ1eoXi21rCAlocqGeiowJjT/xJlJIurfT79QeFKVjPZ07uT5HhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764524559; c=relaxed/simple;
	bh=ww9ikFIpiXUdPQTUCZmroUB8VKRsFlgdLdW8JGR5FzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRvclT2wniPJp4gZHhgRqlq46t5LuC+ZB7ztms/CqAjUHhFriR4GXrgekHlBu7Oj14ovpk2nRPA+xruLrqx8YcVdngWIAWCs9lirS4EBZ/7f8Kpd2Vgq/vvT1dCR3ULzCIKhSq5BTp62igK6ssYvVHdjC82zIB6avetQPyHYySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYpHH8Hq; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYpHH8Hq"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso2599931d50.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Nov 2025 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764524556; x=1765129356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haLVYkWZOmKHtpHDbk/b7m3f6L/rKnHvLY96AT2R3kQ=;
        b=BYpHH8HqQRIphPXDuJ89DZwpZVzI0KLYP2udfHlr9LMIqU58Yef2B4HOMTtF8HuArD
         zgYXU3A5uFzWnzfB5qM37fQxI698LxSlWVxxl3Xlpu0nkSYM0EWWPvGxKsVhVHE29xeA
         5vxkOaj68ub9yqfdDMLcY8ynjMGEtP6zC7uB3MqqZjD2xWRUiNcVke+sNuQO27rpp8Tw
         Zy89U9rejoBjhxTF/KN1XTSXYX0EiAfYUhzHL7aWDubsGSTcbLlVJcPm9B7hOnD9kFhG
         3NBuSHUayXMJ5LZU4wLUwfF5E3hZALfr4GWdPQdrMUQyomTtEJJfPcMcdiFYT76/PF/J
         f1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764524556; x=1765129356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haLVYkWZOmKHtpHDbk/b7m3f6L/rKnHvLY96AT2R3kQ=;
        b=b+WqIl/f5R0liB6jXBKXv98/fw9j9Jcx+0g6Asej40q984xWDgJVcl57MlGOkuAoen
         O9gINhB5GdXat/ljXZm7HZooPMvHR3IsDF9epBrD77iTqwnY/1x0spYq/EuvCfqfcNJJ
         CMwavXVR2Hh/fNUT+/4SOAywAipY1QhnZGfmrwS9/QAP97qNgDwjciL46JXNKWEJF56Y
         1bFjTD1uvxFyej5ocEPqN/4RQx4000l9VFaxuGA1McI+OSntXGFsq0DnXx1Vk3fCQClO
         dLIE/YuZFE4bc1a59trcMWJoTEFGL6iBQncTb/WEFw+o0M3k8uPr03SiDtglLKs7RQlE
         A4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUScbMX+Ymus/AeiGWT1g/Y8JV5H5oCMicVWWADcuc5gQvgnV6tZ3KAuo0M35uZ2bEOQo+QBN9QrzWkYFPlArhJybQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpVN+jx7A0BnNOqbZb0O6rTQWmWkDHwWWBWviuNR+bJqSvUJ/
	YAjRDP/71WKUr+zehCYbHu/8WrcZBt9+Y00PL/mcU7ncobwjWWgP609d
X-Gm-Gg: ASbGnct/7mygDsEYR44Fgj/Ov5D9DPZVFYfJbbISnoC+UxZ8CzY2WOiDM5zMpx9qVSX
	kwJM4rt59PUiYYQxoRQx5j2qGASK1mxz0VelkjY/UODq3K7C38HsRKarUQlBB35EuNmch10eOq6
	5bImMkphEK5eZhbaAOQ5MCXSja8fPSjhwU8dUC71AF1SXv2zOh4dlLI75L9kNBJiB+ItG+f9Ew5
	Q6gqePO+FS/IVEa/k2r4WNHzbl4pjBMt7eHp9se8f7GyeU8b8SVgzcHQpWZ8v0gPmvjCD3BbW0h
	x9t1KSq3XbODg+ufYYlgQPoDPMkOZWlu/OLEB6nmEFtQpNulBDoxeKW8TCPtxyWb2Cerq9pzUXf
	q7L8X4Z6U8oeCnfhFfjrSQS+Nn3LsM++fUVTewdHDZtWbxt/W21DUfwaTSbfRg4XKGhNYTc4xrD
	ILbJAEplI=
X-Google-Smtp-Source: AGHT+IGF0tX2hZjw3AGlknQ4v+/l0LWFo5zB2gFptAlJjQKMRQgk4Vh85OcdRysXZbzgzlA3JZDqcQ==
X-Received: by 2002:a05:690e:14c4:b0:63f:b2ca:80e1 with SMTP id 956f58d0204a3-6432913f51dmr15585557d50.0.1764524555929;
        Sun, 30 Nov 2025 09:42:35 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c443ce5sm3870009d50.12.2025.11.30.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 09:42:35 -0800 (PST)
Date: Sun, 30 Nov 2025 12:42:35 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aSyCC7TQoGgTn2rT@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org>

On Sat, Nov 29, 2025 at 10:19:29PM -0800, Randy Dunlap wrote:
> 
> 
> On 11/29/25 12:24 PM, Andy Shevchenko wrote:
> > On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> >> The macro is related to sysfs, but is defined in kernel.h. Move it to
> >> the proper header, and unload the generic kernel.h.
> > 
> > Tough guy :-)
> > I hope it builds well in your case.
> > 
> > FWIW,
> > https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> > https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> > https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> > 
> > Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I don't build allyesconfigs any more (final? linking takes too long).
> It builds successfully for arm64 allmodconfig, arm allmodconfig,
> i386 allmodconfig, and x86_64 allmodconfig.
> 
> And the source files that use VERIFY_OCTAL_PERMISSIONS() all build successfully
> (which means that they possibly include <linux/sysfs.h> indirectly, i.e.,
> by luck). There aren't many of them, so I checked:
> 
> arch/arc/kernel/perf_event.c:	arc_pmu->attr[j].attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444);
> INDIRECT
> drivers/edac/thunderx_edac.c:	.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		    \
> INDIRECT
> drivers/media/platform/amphion/vpu_dbg.c:		    VERIFY_OCTAL_PERMISSIONS(0644),
> INDIRECT
> drivers/soc/aspeed/aspeed-uart-routing.c:	 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },	\
> INDIRECT
> fs/xfs/xfs_error.c:		 .mode = VERIFY_OCTAL_PERMISSIONS(S_IWUSR | S_IRUGO) },	\
> INDIRECT
> include/linux/moduleparam.h:	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
> INDIRECT
> 
> so all of them got lucky. :)
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Randy.

This series was tested by 0-day and LKP. 0-day runs allyesconfig, as
far as I know. It only sends email in case of errors. LKP is OK, find
the report below.

All but XFS include it via linux/module.h -> linux/moduleparam.h path.
XFS has a linkage layer: xfs.h -> xfs_linux.h-> linux/module.h, so
it's pretty much the same.

I think, module.h inclusion path is OK for this macro and definitely
better than kernel.h. Notice, none of them, except for vgpu_dbg,
include kernel.h directly.

Thanks,
Yury

tree/branch: https://github.com/norov/linux stack_magic
branch HEAD: d8dffbf7bce40e2fbfe077f9c9f4a3471786666f  tracing: move tracing declarations from kernel.h to a dedicated header

elapsed time: 1669m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                     defconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                       defconfig    gcc-15.1.0
arc         randconfig-001-20251128    gcc-8.5.0
arc         randconfig-002-20251128    gcc-15.1.0
arm                     allnoconfig    clang-22
arm           am200epdkit_defconfig    gcc-15.1.0
arm             aspeed_g5_defconfig    gcc-15.1.0
arm         randconfig-001-20251128    gcc-14.3.0
arm         randconfig-002-20251128    gcc-8.5.0
arm         randconfig-003-20251128    clang-22
arm         randconfig-004-20251128    clang-17
arm               s3c6400_defconfig    gcc-15.1.0
arm                 u8500_defconfig    gcc-15.1.0
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251129    clang-22
arm64       randconfig-002-20251129    clang-22
arm64       randconfig-003-20251129    gcc-8.5.0
arm64       randconfig-004-20251129    clang-22
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251129    gcc-15.1.0
csky        randconfig-002-20251129    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251129    clang-22
hexagon     randconfig-002-20251129    clang-22
i386                    allnoconfig    gcc-14
i386        randconfig-001-20251129    gcc-14
i386        randconfig-002-20251129    gcc-12
i386        randconfig-003-20251129    clang-20
i386        randconfig-004-20251129    gcc-14
i386        randconfig-005-20251129    clang-20
i386        randconfig-006-20251129    clang-20
i386        randconfig-007-20251129    gcc-14
i386        randconfig-011-20251129    clang-20
i386        randconfig-012-20251129    gcc-13
i386        randconfig-013-20251129    clang-20
i386        randconfig-014-20251129    clang-20
i386        randconfig-015-20251129    gcc-14
loongarch               allnoconfig    clang-22
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20251129    gcc-15.1.0
loongarch   randconfig-002-20251129    gcc-14.3.0
m68k                    allnoconfig    gcc-15.1.0
m68k                      defconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze                defconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
nios2       randconfig-001-20251129    gcc-11.5.0
nios2       randconfig-002-20251129    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc                  defconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                    defconfig    gcc-15.1.0
parisc      generic-64bit_defconfig    gcc-15.1.0
parisc      randconfig-001-20251128    gcc-14.3.0
parisc      randconfig-002-20251128    gcc-15.1.0
parisc64                  defconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc            pcm030_defconfig    clang-22
powerpc     randconfig-001-20251128    gcc-11.5.0
powerpc     randconfig-002-20251128    clang-22
powerpc64   randconfig-001-20251128    clang-22
powerpc64   randconfig-002-20251128    gcc-8.5.0
riscv                   allnoconfig    gcc-15.1.0
riscv                     defconfig    clang-22
s390                    allnoconfig    clang-22
s390                      defconfig    clang-22
sh                      allnoconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-001-20251129    gcc-8.5.0
sparc       randconfig-002-20251129    gcc-8.5.0
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20251129    gcc-8.5.0
sparc64     randconfig-002-20251129    gcc-14.3.0
um                      allnoconfig    clang-22
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um          randconfig-001-20251129    clang-22
um          randconfig-002-20251129    gcc-14
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64      randconfig-011-20251129    gcc-14
x86_64      randconfig-012-20251129    gcc-14
x86_64      randconfig-013-20251129    gcc-14
x86_64      randconfig-014-20251129    clang-20
x86_64      randconfig-015-20251129    gcc-12
x86_64      randconfig-016-20251129    clang-20
x86_64      randconfig-071-20251129    gcc-14
x86_64      randconfig-072-20251129    clang-20
x86_64      randconfig-073-20251129    gcc-14
x86_64      randconfig-074-20251129    gcc-12
x86_64      randconfig-075-20251129    gcc-14
x86_64      randconfig-076-20251129    gcc-14
xtensa                  allnoconfig    gcc-15.1.0
xtensa      randconfig-001-20251129    gcc-10.5.0
xtensa      randconfig-002-20251129    gcc-14.3.0
xtensa          xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
