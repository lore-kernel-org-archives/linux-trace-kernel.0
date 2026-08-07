Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930047011F;
	Fri,  7 Aug 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098620; cv=none; b=f0bANfoSSj5T2H5e8hzneebk9t84gWqv4QI3YJSm+fqVHLDXP7YjkO3JfFcOYBy+JhErr2aueuym3kdf7BOGyKojoMTfeBpftdA8UyI1nQgS+MYYMq5EXqilS6+n1K8cDg2OYJkRv8qqClnu6ND/JbTKfNqX1cDHeqX9AlO8tCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098620; c=relaxed/simple;
	bh=65SnBkKgpNg1bsafp7VGHMOEGAmrM4yY6cpRnA+3vFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o+EIlXAPR7250ThZaecDC7PdGCkUeECXSu367sUPRn7aeQXharvvFi+0MuVyeDAWJg+1sgit49wow6NFSF7QqUZhvCiuXd8UMUQXxf4Krb8B5HiKOu6NjFXNz5PjBi/0FsqGWUefU5japzhIxwoo3Igf8WiAmuX25iBTpjiYElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQzWs8wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQzWs8wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B101F000E9;
	Fri,  7 Aug 2026 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786098617;
	bh=D57BfGvE5e2Os2mPHIcMDuZXtKECmeWmZYmGAmiUz34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aQzWs8wq+XMWmhGbeVqv6S5c9jg2C3sGoqij4SztGeBGWz9Q4im84gyQM7Lkmb5GD
	 3UyKlt7FvvMChAPHXSl3/JtjH5+DJkjWLiZ++v/spwYCbDEes+xKx9gGKEyq2wRhBP
	 EI5BVsDnKquuviYY7w2a/E43QYvshGvcf8sN+5z3O/GhFYiff4bTA6bURAKc0+r/qX
	 kq4iLLu65YO2IY/qWYb16kiw05rOWpgSAG6qoiHDCkm7g3LjtdMgKxQE5z4ONbloXb
	 qohYlk6+A70B2iXjagZYZWitFwBr7VBIKXSDjLShxfyhuyI7BriFxaiONrNGQdZghU
	 NU45pJZqyySfA==
Date: Fri, 7 Aug 2026 19:30:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Convert ELF entry point to
 file offset in uprobe test
Message-Id: <20260807193013.7fe47144c1f41facb60b310f@kernel.org>
In-Reply-To: <20260807081512.2974757-3-qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com>
	<20260807081512.2974757-1-qirui.001@bytedance.com>
	<20260807081512.2974757-3-qirui.001@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 16:15:12 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> The add_remove_uprobe test uses readelf -h to obtain the ELF entry
> point (e_entry) and passes it directly as the offset to uprobe_events.
> However, uprobe_events expects a file offset, not a virtual address.
> 
> For PIE binaries, the virtual address happens to equal the file offset
> because the first LOAD segment has p_vaddr == p_offset, so the test
> works by coincidence. But for non-PIE executables, e_entry is an
> absolute virtual address that can far exceed the file size. When the
> probe is enabled, uprobe_register() checks offset > i_size_read(inode)
> and rejects it with -EINVAL.

Good catch!

> 
> Fix this by converting the virtual address to a file offset using the
> ELF program headers: scan readelf -lW output for the LOAD segment
> containing the entry point, then compute file_offset = e_entry -
> p_vaddr + p_offset. For PIE binaries the result is unchanged; for
> non-PIE binaries the offset is correctly translated.
> 
> The conversion uses only POSIX shell primitives, with no dependency on
> gawk or perl.
> 
> Fixes: dc4b165855f2 ("selftests/ftrace: Use readelf to find entry point in uprobe test")
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

OK, let me take it.

Thank you!

> ---
>  .../test.d/dynevent/add_remove_uprobe.tc      | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> index f2048c244526..19430bd5864c 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
> @@ -12,9 +12,32 @@ echo 0 > events/enable
>  echo > dynamic_events
>  
>  REALBIN=`readlink -f /bin/sh`
> -ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
>  
> -echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
> +# Get the entry point virtual address from ELF header
> +ENTRY=`readelf -hW ${REALBIN} | grep "Entry point" | awk '{print $NF}'`
> +
> +# Convert virtual address to file offset: find the LOAD segment containing
> +# the entry point, then compute file_offset = e_entry - p_vaddr + p_offset.
> +# For PIE binaries this is a no-op (vaddr == file offset), but for non-PIE
> +# executables the virtual address is much larger than the file size and
> +# must be converted, otherwise uprobe_register() rejects it with -EINVAL.
> +ENTRY_DEC=$(printf '%d' "$ENTRY")
> +OFFSET=$ENTRY
> +while IFS= read -r line; do
> +    set -- $line
> +    [ "$1" = "LOAD" ] || continue
> +    VA_DEC=$(printf '%d' "$3")
> +    OFF_DEC=$(printf '%d' "$2")
> +    FSZ_DEC=$(printf '%d' "$5")
> +    if [ "$ENTRY_DEC" -ge "$VA_DEC" ] && [ "$ENTRY_DEC" -lt "$((VA_DEC + FSZ_DEC))" ]; then
> +        OFFSET=$(printf '0x%x' "$((ENTRY_DEC - VA_DEC + OFF_DEC))")
> +        break
> +    fi
> +done << EOF
> +$(readelf -lW ${REALBIN} | grep LOAD)
> +EOF
> +
> +echo "p:myevent ${REALBIN}:${OFFSET}" >> uprobe_events
>  
>  grep -q myevent uprobe_events
>  test -d events/uprobes/myevent
> -- 
> 2.20.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
