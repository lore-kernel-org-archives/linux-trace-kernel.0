Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E57168BD;
	Fri, 12 Sep 2025 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638912; cv=none; b=Swj6qlAiXw3ArelUFCZ79W4YTS7y5k0vDNUG3rpEvxR/6o559TfG4ElnR5Fx0aJK2mrWoGCpHNZS3nPaq0DvXYB6RZnnlAinssD/R8duTWXJ1yljyMX+a2GNJcqhTveq5UGWgIxdikOMHngONdLSBCC9TiS2AHliluUYcE1yo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638912; c=relaxed/simple;
	bh=cwIa3L6pVeCvHlXrMetDwmrNPir3lOVlkQuzvO85JGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uWHdn7carOcVqry6V6j3BRGOlOvGbmERTzlJoq/auQ7HuX05A/2zwPF7pQvRqJolFB3SCX1pRBaCpLhSFYvHrkGtMYNdnxj8WLOp34tHGPFOW4tKJtzKHg/ZQXug6uLgasnJsD6sex2wdrFQ2ssEzVXKKs/8k/P7/PYISr3eJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUMdew4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUMdew4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B984FC4CEF0;
	Fri, 12 Sep 2025 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757638911;
	bh=cwIa3L6pVeCvHlXrMetDwmrNPir3lOVlkQuzvO85JGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUMdew4plSbUY5QynvTzsVb3n3bnrwK1nAMmwDZ4EH7sCq1rDcDYNzP6b5q1t588x
	 G9fFJUiFoiklXBDTw7E8PyTeANwOLqtibvBw6+XIUds73Mb3Q4XIhTkFfgVOwqfLWD
	 OaPj06TN1xIACUUQyNiyOaALQ2a2rb6uHDCxMUe5OCCyGu0CdMursFMUw8dJAeiX4k
	 NR3D0M1iAai1efrefv8vAGT5OR1xhFjL5TFvKoJ/YN9DhQfL+TSEv2QI4BQyezGmBR
	 njPkdDSN/g62jCOfZoNYU4/GX2xXMcs9BSzpcR5Pz9WwZPZl2z3E0eOqd3LDA+xGrl
	 YBO39nfHwYtKw==
Date: Fri, 12 Sep 2025 10:01:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/5] Documentation: trace: histogram-design: Trim
 trailing vertices in diagram explanation text
Message-Id: <20250912100146.0e9948c812985ca45bfee087@kernel.org>
In-Reply-To: <20250911042527.22573-3-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	<20250911042527.22573-3-bagasdotme@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:25:24 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Diagram explanation text is supposed to be interleaved commentary
> between diagram parts that are spread out, but it outputs ugly in
> htmldocs due to trailing vertices as if both the explanation and the
> diagram are in the same literal code block.
> 
> Trim trailing vertices.

I got it (e.g. https://docs.kernel.org/trace/histogram-design.html),
yeah it should be removed.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram-design.rst | 138 +++++++++++------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index 5765eb3e9efa78..231a12bd7d461c 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -142,30 +142,30 @@ elements for a couple hypothetical keys and values.::
>                               +--------------+                            |  |
>                                              n_keys = n_fields - n_vals   |  |
>  
> -The hist_data n_vals and n_fields delineate the extent of the fields[]   |  |
> -array and separate keys from values for the rest of the code.            |  |
> +The hist_data n_vals and n_fields delineate the extent of the fields[]
> +array and separate keys from values for the rest of the code.
>  
> -Below is a run-time representation of the tracing_map part of the        |  |
> -histogram, with pointers from various parts of the fields[] array        |  |
> -to corresponding parts of the tracing_map.                               |  |
> +Below is a run-time representation of the tracing_map part of the
> +histogram, with pointers from various parts of the fields[] array
> +to corresponding parts of the tracing_map.
>  
> -The tracing_map consists of an array of tracing_map_entrys and a set     |  |
> -of preallocated tracing_map_elts (abbreviated below as map_entry and     |  |
> -map_elt).  The total number of map_entrys in the hist_data.map array =   |  |
> -map->max_elts (actually map->map_size but only max_elts of those are     |  |
> -used.  This is a property required by the map_insert() algorithm).       |  |
> +The tracing_map consists of an array of tracing_map_entrys and a set
> +of preallocated tracing_map_elts (abbreviated below as map_entry and
> +map_elt).  The total number of map_entrys in the hist_data.map array =
> +map->max_elts (actually map->map_size but only max_elts of those are
> +used.  This is a property required by the map_insert() algorithm).
>  
> -If a map_entry is unused, meaning no key has yet hashed into it, its     |  |
> -.key value is 0 and its .val pointer is NULL.  Once a map_entry has      |  |
> -been claimed, the .key value contains the key's hash value and the       |  |
> -.val member points to a map_elt containing the full key and an entry     |  |
> -for each key or value in the map_elt.fields[] array.  There is an        |  |
> -entry in the map_elt.fields[] array corresponding to each hist_field     |  |
> -in the histogram, and this is where the continually aggregated sums      |  |
> -corresponding to each histogram value are kept.                          |  |
> +If a map_entry is unused, meaning no key has yet hashed into it, its
> +.key value is 0 and its .val pointer is NULL.  Once a map_entry has
> +been claimed, the .key value contains the key's hash value and the
> +.val member points to a map_elt containing the full key and an entry
> +for each key or value in the map_elt.fields[] array.  There is an
> +entry in the map_elt.fields[] array corresponding to each hist_field
> +in the histogram, and this is where the continually aggregated sums
> +corresponding to each histogram value are kept.
>  
> -The diagram attempts to show the relationship between the                |  |
> -hist_data.fields[] and the map_elt.fields[] with the links drawn         |  |
> +The diagram attempts to show the relationship between the
> +hist_data.fields[] and the map_elt.fields[] with the links drawn
>  between diagrams::
>  
>    +-----------+		                                                 |  |
> @@ -440,31 +440,31 @@ sched_waking histogram
>                                               n_keys = n_fields - n_vals   | | |
>                                                                            | | |
>  
> -This is very similar to the basic case.  In the above diagram, we can     | | |
> -see a new .flags member has been added to the struct hist_field           | | |
> -struct, and a new entry added to hist_data.fields representing the ts0    | | |
> -variable.  For a normal val hist_field, .flags is just 0 (modulo          | | |
> -modifier flags), but if the value is defined as a variable, the .flags    | | |
> -contains a set FL_VAR bit.                                                | | |
> +This is very similar to the basic case.  In the above diagram, we can
> +see a new .flags member has been added to the struct hist_field
> +struct, and a new entry added to hist_data.fields representing the ts0
> +variable.  For a normal val hist_field, .flags is just 0 (modulo
> +modifier flags), but if the value is defined as a variable, the .flags
> +contains a set FL_VAR bit.
>  
> -As you can see, the ts0 entry's .var.idx member contains the index        | | |
> -into the tracing_map_elts' .vars[] array containing variable values.      | | |
> -This idx is used whenever the value of the variable is set or read.       | | |
> -The map_elt.vars idx assigned to the given variable is assigned and       | | |
> -saved in .var.idx by create_tracing_map_fields() after it calls           | | |
> -tracing_map_add_var().                                                    | | |
> +As you can see, the ts0 entry's .var.idx member contains the index
> +into the tracing_map_elts' .vars[] array containing variable values.
> +This idx is used whenever the value of the variable is set or read.
> +The map_elt.vars idx assigned to the given variable is assigned and
> +saved in .var.idx by create_tracing_map_fields() after it calls
> +tracing_map_add_var().
>  
> -Below is a representation of the histogram at run-time, which             | | |
> -populates the map, along with correspondence to the above hist_data and   | | |
> -hist_field data structures.                                               | | |
> +Below is a representation of the histogram at run-time, which
> +populates the map, along with correspondence to the above hist_data and
> +hist_field data structures.
>  
> -The diagram attempts to show the relationship between the                 | | |
> -hist_data.fields[] and the map_elt.fields[] and map_elt.vars[] with       | | |
> -the links drawn between diagrams.  For each of the map_elts, you can      | | |
> -see that the .fields[] members point to the .sum or .offset of a key      | | |
> -or val and the .vars[] members point to the value of a variable.  The     | | |
> -arrows between the two diagrams show the linkages between those           | | |
> -tracing_map members and the field definitions in the corresponding        | | |
> +The diagram attempts to show the relationship between the
> +hist_data.fields[] and the map_elt.fields[] and map_elt.vars[] with
> +the links drawn between diagrams.  For each of the map_elts, you can
> +see that the .fields[] members point to the .sum or .offset of a key
> +or val and the .vars[] members point to the value of a variable.  The
> +arrows between the two diagrams show the linkages between those
> +tracing_map members and the field definitions in the corresponding
>  hist_data fields[] members.::
>  
>    +-----------+		                                                  | | |
> @@ -565,40 +565,40 @@ hist_data fields[] members.::
>                                                        |               |     | |
>                                                        +---------------+     | |
>  
> -For each used map entry, there's a map_elt pointing to an array of          | |
> -.vars containing the current value of the variables associated with         | |
> -that histogram entry.  So in the above, the timestamp associated with       | |
> -pid 999 is 113345679876, and the timestamp variable in the same             | |
> -.var.idx for pid 4444 is 213499240729.                                      | |
> +For each used map entry, there's a map_elt pointing to an array of
> +.vars containing the current value of the variables associated with
> +that histogram entry.  So in the above, the timestamp associated with
> +pid 999 is 113345679876, and the timestamp variable in the same
> +.var.idx for pid 4444 is 213499240729.
>  
> -sched_switch histogram                                                      | |
> -----------------------                                                      | |
> +sched_switch histogram
> +----------------------
>  
> -The sched_switch histogram paired with the above sched_waking               | |
> -histogram is shown below.  The most important aspect of the                 | |
> -sched_switch histogram is that it references a variable on the              | |
> -sched_waking histogram above.                                               | |
> +The sched_switch histogram paired with the above sched_waking
> +histogram is shown below.  The most important aspect of the
> +sched_switch histogram is that it references a variable on the
> +sched_waking histogram above.
>  
> -The histogram diagram is very similar to the others so far displayed,       | |
> -but it adds variable references.  You can see the normal hitcount and       | |
> -key fields along with a new wakeup_lat variable implemented in the          | |
> -same way as the sched_waking ts0 variable, but in addition there's an       | |
> -entry with the new FL_VAR_REF (short for HIST_FIELD_FL_VAR_REF) flag.       | |
> +The histogram diagram is very similar to the others so far displayed,
> +but it adds variable references.  You can see the normal hitcount and
> +key fields along with a new wakeup_lat variable implemented in the
> +same way as the sched_waking ts0 variable, but in addition there's an
> +entry with the new FL_VAR_REF (short for HIST_FIELD_FL_VAR_REF) flag.
>  
> -Associated with the new var ref field are a couple of new hist_field        | |
> -members, var.hist_data and var_ref_idx.  For a variable reference, the      | |
> -var.hist_data goes with the var.idx, which together uniquely identify       | |
> -a particular variable on a particular histogram.  The var_ref_idx is        | |
> -just the index into the var_ref_vals[] array that caches the values of      | |
> -each variable whenever a hist trigger is updated.  Those resulting          | |
> -values are then finally accessed by other code such as trace action         | |
> -code that uses the var_ref_idx values to assign param values.               | |
> +Associated with the new var ref field are a couple of new hist_field
> +members, var.hist_data and var_ref_idx.  For a variable reference, the
> +var.hist_data goes with the var.idx, which together uniquely identify
> +a particular variable on a particular histogram.  The var_ref_idx is
> +just the index into the var_ref_vals[] array that caches the values of
> +each variable whenever a hist trigger is updated.  Those resulting
> +values are then finally accessed by other code such as trace action
> +code that uses the var_ref_idx values to assign param values.
>  
> -The diagram below describes the situation for the sched_switch              | |
> +The diagram below describes the situation for the sched_switch
>  histogram referred to before::
>  
> -  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0' >>     | |
> -          events/sched/sched_switch/trigger                                 | |
> +  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0' >>
> +          events/sched/sched_switch/trigger
>                                                                              | |
>    +------------------+                                                      | |
>    | hist_data        |                                                      | |
> -- 
> An old man doll... just what I always wanted! - Clara
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
