Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC77132135;
	Tue,  4 Jun 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480357; cv=none; b=gu/zCbUD+oQ1ubNOzyhatdJULfjd0f3sPbP5ZZ/H0SCQ3bQDI9sA94vhDlR/tp22V1WHqTxs9SevxJGQSlBgNBzxetpbd1nGPUJ8ZUH3JPFzpbL775SBAzBhHxN5YRcpr7C1e2xsiEIq1TaS+PVWBSy3xa9DJPrPm30zXioCEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480357; c=relaxed/simple;
	bh=hp/q9fl1l/6+eFOkIX8ny4QgcjTOK17pB3rxlmTZ8Iw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tnij5pIVxgorKoIRHjMFCfu4GjPMlEgnZKP6XtHP676WbCNxEivDf8gFp4F0PFvh33zT/fRv65a9LjyOaAd5iqRH+1DM/NpOIiza72bDxTFBGAIvMb2oax5HWTibr+ytcmo1K/FNmJ+rsh2Gh8NdymhlxX5HEFULMPaYQmBQwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRygG54C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRygG54C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A96C2BBFC;
	Tue,  4 Jun 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717480356;
	bh=hp/q9fl1l/6+eFOkIX8ny4QgcjTOK17pB3rxlmTZ8Iw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rRygG54CoZ8htmevLQ2Hwd3ZKINlMR4WCoy3mGZm7Er7VXEGvDHQ4Hxm8Fvhepf6G
	 xEMuSpoBut1mphalvVhYydblbpdlzb9tM6341UEtCE+SYUIpv3WBE/bsBoCYxCutSM
	 XYUumCwRSdEgTN/mEIo7JIgarVXj5ERxHBHWdZoRAdXpgSToo4JXHm/GyuJCd3wDBr
	 5vYjNG6497Phbm/PJ9zukKXKSRmm0QPgH9ER9iIQiUux4Q8rquDIPIqY5szq2BVoG6
	 fdNd2eK8IcYXXbNAe5srDrLtFRI6j9h/cMgIz3X04EHoLjc1Lo6nI9BZWWuBNFy1yz
	 fpNdjbjPA6yYA==
Date: Mon, 03 Jun 2024 22:52:37 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, ardb@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_mm/memblock=3A_Add_=22reserve?=
 =?US-ASCII?Q?=5Fmem=22_to_reserved_named_memory_at_boot_up?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240603233631.452433539@goodmis.org>
References: <20240603233330.801075898@goodmis.org> <20240603233631.452433539@goodmis.org>
Message-ID: <5DAB46F6-F415-4C2B-AA6A-E0049CF6270C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 3, 2024 4:33:31 PM PDT, Steven Rostedt <rostedt@goodmis=2Eorg> wro=
te:
>From: "Steven Rostedt (Google)" <rostedt@goodmis=2Eorg>
>
>In order to allow for requesting a memory region that can be used for
>things like pstore on multiple machines where the memory layout is not th=
e
>same, add a new option to the kernel command line called "reserve_mem"=2E
>
>The format is:  reserve_mem=3Dnn:align:name
>
>Where it will find nn amount of memory at the given alignment of align=2E
>The name field is to allow another subsystem to retrieve where the memory
>was found=2E For example:
>
>  reserve_mem=3D12M:4096:oops ramoops=2Emem_name=3Doops

How does this interact with KASLR? It has chosen its physical location bef=
ore this parsing happens, so I'd expect this to fail once in a while, unles=
s the size/alignment is lucky enough that KASLR never uses that portion of =
the physical memory=2E=2E=2E

-Kees

>
>Where ramoops=2Emem_name will tell ramoops that memory was reserved for i=
t
>via the reserve_mem option and it can find it by calling:
>
>  if (reserve_mem_find_by_name("oops", &start, &size)) {
>	// start holds the start address and size holds the size given
>
>Link: https://lore=2Ekernel=2Eorg/all/ZjJVnZUX3NZiGW6q@kernel=2Eorg/
>
>Suggested-by: Mike Rapoport <rppt@kernel=2Eorg>
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>---
> include/linux/mm=2Eh |  2 +
> mm/memblock=2Ec      | 97 ++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 99 insertions(+)
>
>diff --git a/include/linux/mm=2Eh b/include/linux/mm=2Eh
>index 9849dfda44d4=2E=2Eb4455cc02f2c 100644
>--- a/include/linux/mm=2Eh
>+++ b/include/linux/mm=2Eh
>@@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigne=
d long pfn)
> void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> void vma_pgtable_walk_end(struct vm_area_struct *vma);
>=20
>+int reserve_mem_find_by_name(const char *name, unsigned long *start, uns=
igned long *size);
>+
> #endif /* _LINUX_MM_H */
>diff --git a/mm/memblock=2Ec b/mm/memblock=2Ec
>index d09136e040d3=2E=2Ea8bf0ee9e2b4 100644
>--- a/mm/memblock=2Ec
>+++ b/mm/memblock=2Ec
>@@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
> 	totalram_pages_add(pages);
> }
>=20
>+/* Keep a table to reserve named memory */
>+#define RESERVE_MEM_MAX_ENTRIES		8
>+#define RESERVE_MEM_NAME_SIZE		16
>+struct reserve_mem_table {
>+	char			name[RESERVE_MEM_NAME_SIZE];
>+	unsigned long		start;
>+	unsigned long		size;
>+};
>+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRI=
ES];
>+static int reserved_mem_count;
>+
>+/* Add wildcard region with a lookup name */
>+static int __init reserved_mem_add(unsigned long start, unsigned long si=
ze,
>+				   const char *name)
>+{
>+	struct reserve_mem_table *map;
>+
>+	if (!name || !name[0] || strlen(name) >=3D RESERVE_MEM_NAME_SIZE)
>+		return -EINVAL;
>+
>+	if (reserved_mem_count >=3D RESERVE_MEM_MAX_ENTRIES)
>+		return -1;
>+
>+	map =3D &reserved_mem_table[reserved_mem_count++];
>+	map->start =3D start;
>+	map->size =3D size;
>+	strscpy(map->name, name);
>+	return 0;
>+}
>+
>+/**
>+ * reserve_mem_find_by_name - Find reserved memory region with a given n=
ame
>+ * @name: The name that is attached to a reserved memory region
>+ * @start: If found, holds the start address
>+ * @size: If found, holds the size of the address=2E
>+ *
>+ * Returns: 1 if found or 0 if not found=2E
>+ */
>+int reserve_mem_find_by_name(const char *name, unsigned long *start, uns=
igned long *size)
>+{
>+	struct reserve_mem_table *map;
>+	int i;
>+
>+	for (i =3D 0; i < reserved_mem_count; i++) {
>+		map =3D &reserved_mem_table[i];
>+		if (!map->size)
>+			continue;
>+		if (strcmp(name, map->name) =3D=3D 0) {
>+			*start =3D map->start;
>+			*size =3D map->size;
>+			return 1;
>+		}
>+	}
>+	return 0;
>+}
>+
>+/*
>+ * Parse early_reserve_mem=3Dnn:align:name
>+ */
>+static int __init reserve_mem(char *p)
>+{
>+	phys_addr_t start, size, align;
>+	char *oldp;
>+	int err;
>+
>+	if (!p)
>+		return -EINVAL;
>+
>+	oldp =3D p;
>+	size =3D memparse(p, &p);
>+	if (p =3D=3D oldp)
>+		return -EINVAL;
>+
>+	if (*p !=3D ':')
>+		return -EINVAL;
>+
>+	align =3D memparse(p+1, &p);
>+	if (*p !=3D ':')
>+		return -EINVAL;
>+
>+	start =3D memblock_phys_alloc(size, align);
>+	if (!start)
>+		return -ENOMEM;
>+
>+	p++;
>+	err =3D reserved_mem_add(start, size, p);
>+	if (err) {
>+		memblock_phys_free(start, size);
>+		return err;
>+	}
>+
>+	p +=3D strlen(p);
>+
>+	return *p =3D=3D '\0' ? 0: -EINVAL;
>+}
>+__setup("reserve_mem=3D", reserve_mem);
>+
> #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> static const char * const flagname[] =3D {
> 	[ilog2(MEMBLOCK_HOTPLUG)] =3D "HOTPLUG",

--=20
Kees Cook
